import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'calender.dart';
import 'info.dart';

class today extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<today> {
  // Firestore에서 오늘의 일정을 가져오는 Stream
  Stream<QuerySnapshot> _getTodayEvents() {
    // Firestore에서 "events" 컬렉션의 오늘 날짜에 해당하는 데이터를 가져오는 쿼리
    return FirebaseFirestore.instance
        .collection('events')
        .where('date', isEqualTo: DateTime.now().toIso8601String())
        .snapshots();
  }

  int _selectedIndex = 1; // 현재 선택된 버튼 인덱스

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      // 현재 선택된 버튼을 다시 누른 경우, 아무 동작도 하지 않음
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // 버튼 클릭 시 네비게이션
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarPage(), // 새 화면 위젯
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => info(), // 다른 화면 위젯
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 일정'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getTodayEvents(), // Firestore에서 실시간으로 데이터를 가져옴
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('오늘의 일정이 없습니다.'));
          }

          // Firestore에서 가져온 일정을 리스트로 표시
          var events = snapshot.data!.docs;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              var event = events[index];
              return ListTile(
                title: Text(event['title'] ?? '제목 없음'),
                subtitle: Text(event['startTime'] ?? '시작 시간 미정'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // 일정 삭제
                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(event.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '오늘의 할일',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '나',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        onTap: _onItemTapped, // 탭 이벤트 처리
      ),
    );
  }
}
