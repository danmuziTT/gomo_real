import 'package:flutter/material.dart';
import 'manage_point.dart';

void main() {
  runApp(pointhistory());
}

class pointhistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PointHistoryScreen(),
    );
  }
}

class PointHistoryScreen extends StatefulWidget {
  @override
  _PointHistoryScreenState createState() => _PointHistoryScreenState();
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  List<PointHistory> pointHistoryList = [
    PointHistory('12/1', '테마 구매', 20),
    PointHistory('12/2', '일정 전부 완료 보상', 10),
    PointHistory('12/3', '고양이 스티커 구매', -5),
    PointHistory('12/4', '강아지 스티커 구매', -5),
    PointHistory('12/5', '일정 전부 완료 보상', 20),
    // 더 많은 데이터를 추가할 수 있습니다
  ];

  int totalPoints = 1200; // 초기 총 포인트

  @override
  void initState() {
    super.initState();
    // 포인트 내역을 최신순으로 정렬
    pointHistoryList.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('포인트 적립 내역'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => pointmanage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // 총 포인트 표시, 중앙에 위치
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '총 포인트: $totalPoints',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pointHistoryList.length,
              itemBuilder: (context, index) {
                final history = pointHistoryList[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  leading: Text(history.date, style: TextStyle(fontSize: 16)),
                  title: Text(history.activity, style: TextStyle(fontSize: 16)),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 16.0),  // 포인트 증감 부분을 안쪽으로 이동
                    child: Text(
                      history.points > 0 ? '+${history.points}' : '${history.points}',
                      style: TextStyle(
                        fontSize: 16,
                        color: history.points > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PointHistory {
  final String date;
  final String activity;
  final int points;

  PointHistory(this.date, this.activity, this.points);
}
