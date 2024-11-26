import 'package:flutter/material.dart';
import 'today.dart';

class Login extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "로그인하기",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),
            // 아이디 입력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이메일", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이메일 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // 위아래 간격

            // 비밀번호 입력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                String id = _idController.text;
                String psw = _passwordController.text;
                if(id == "")
                  {
                    _showErrorDialog(context, "오류!", "아이디를 입력하시오");
                  } //아이디 입력 안 한 경우
                else if (psw == "")
                  {
                    _showErrorDialog(context, "오류!", "비밀번호를 입력하시오");
                  } //비밀번호 입력 안 한 경우
              },
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
