import 'package:flutter/material.dart';
import 'today.dart';

// 전역 변수로 선언
int add = 0; // 하루 증감량 체크, 파이어베이스 연동 필요(이력에 필요함)
int point = 1200; // 현재 포인트, 파이어베이스 연동 필요

void main() {
  // 전역 변수 `add` 값을 기준으로 앱 실행
  if (add < 100) {
    runApp(pointadd());
  } else {
    runApp(overpoint());
  }
}

class pointadd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PointManager(),
    );
  }
}

class PointManager extends StatefulWidget {
  @override
  _PointManagerState createState() => _PointManagerState();
}

class _PointManagerState extends State<PointManager> {
  final int addPoint = 10; // 포인트 증감량

  @override
  Widget build(BuildContext context) {
    if (add < 100) {
      return PointAddScreen(
        onAddPoint: () {
          setState(() {
            point += addPoint; // 전역 변수 업데이트
            add += addPoint;   // 전역 변수 업데이트
          });
        },
      );
    } else {
      return overpoint();
    }
  }
}

class PointAddScreen extends StatelessWidget {
  final VoidCallback onAddPoint;

  PointAddScreen({required this.onAddPoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text(
                '"추가한 일정 1"\n완료했어요', //추가한 일정1을 클릭한 일정의 이름으로 바뀔 수 있도로 바꾸기
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '계획의 실천은\n참 좋은 습관이에요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              Text(
                '계획 포인트 +10',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    onAddPoint(); // 이 부분에서 콜백 호출
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => today()),
                    );
                  },
                  child: Text(
                    '오늘의 일정으로 돌아가기',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class overpoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money, size: 120, color: Colors.green),
              SizedBox(height: 20),
              Text(
                '"추가한 일정 1"\n완료했어요', //추가한 일정1을 클릭한 일정의 이름으로 바뀔 수 있도로 바꾸기
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '계획의 실천은\n참 좋은 습관이에요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              Text(
                '오늘 받을 수 있는 포인트를 모두 받았어요.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => today()),
                    );
                  },
                  child: Text(
                    '오늘의 일정으로 돌아가기',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
