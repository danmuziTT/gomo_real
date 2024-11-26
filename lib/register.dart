import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _nameregister = TextEditingController(); //이름 등록
  final TextEditingController _idregister = TextEditingController(); // 이메일 등록
  final TextEditingController _passwordregister = TextEditingController(); // 비밀번호 등록
  final TextEditingController _passwordregister2 = TextEditingController(); // 비밀번호 맞는지 확인용

  final FirebaseAuth _auth = FirebaseAuth.instance; //파이어베이스어스 인스턴트


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
              onPressed: () {
                String regist_name = _nameregister.text;
                String regist_id = _idregister.text;
                String regist_psw = _passwordregister.text;
                String regist_psw2 = _passwordregister2.text;

                bool isalpha_ = RegExp(r'^[a-zA-Z]+$').hasMatch(regist_psw);
                bool isnum_ = RegExp(r'^[0-9]+$').hasMatch(regist_psw)
                if (regist_psw != regist_psw2) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("비밀번호가 일치하지 않습니다"),
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
                } //비밀번호 일치하지 않는다면

                else if (regist_psw.length > 12) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("비밀번호는 12자리 이내여야 합니다"),
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
                } //비밀번호가 12자리 초과인 경우

                else if (regist_name == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("이름은 꼭 입력해야 합니다"),
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
                } //이름이 입력되지 않은 경우

                else if (regist_id == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("이메일은 꼭 입력해야 합니다"),
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
                } //이메일 입력을 하지 않는 경우

                else if (regist_psw == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("비밀번호는 꼭 입력해야 합니다"),
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
                } //비밀번호칸에 아무것도 없는경우

                else if (regist_psw2 == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("비밀번호 확인을 꼭 입력해야 합니다"),
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
                } //비밀번호 확인 칸에 아무것도 없는경우

                else if(isnum_ == true || isalpha_ == true ){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류!"),
                        content: const Text("비밀번호에는 숫자와 문자가 모두 포함되어있어야 합니다"),
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
                } //비밀번호에 숫자만 있거나, 문자만 있는 경우
              },
              child: Text("회원가입하기"),
            ),
          ],
        ),
      ),
    );
  }
}
