import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'firebase_options.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Task Quest에 로그인하기", style: TextStyle(fontSize: 30.0, color: Colors.blue),),
          SizedBox(height: 30),
          ElevatedButton(
            child: Text("로그인하기"),
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login()),
            );
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            );
            },
          ),


          Text(""),
          ElevatedButton(
            child: Text("회원가입하기"),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> register()),
              );
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
