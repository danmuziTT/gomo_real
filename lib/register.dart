import 'package:flutter/material.dart';

class register extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _nameregister = TextEditingController(); //이름 등록
  final TextEditingController _idregister = TextEditingController(); // 이메일 등록
  final TextEditingController _passwordregister = TextEditingController(); // 비밀번호 등록
  final TextEditingController _passwordregister2 = TextEditingController(); // 비밀번호 맞는지 확인용


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0), // 화면 여백 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "회원가입하기",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이름", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _nameregister,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이름 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이메일", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _idregister,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이메일 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordregister,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호 다시 입력하기", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordregister2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 한번 더 입력",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                String regist_name = _nameregister.text;
                String regist_id = _idregister.text;
                String regist_psw = _passwordregister.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("이름: $regist_name   이메일 : $regist_id   비밀번호: $regist_psw")),
                );
              },
              child: Text("회원가입하기"),

            ),
          ],
        ),
      ),
    );
  }
}
