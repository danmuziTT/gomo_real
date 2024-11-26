import 'package:flutter/material.dart';
import 'today.dart';

class Login extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                String password = _passwordController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("이메일: $id, 비밀번호: $password")),
                );
              },
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
