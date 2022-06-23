import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/registerscreen.dart';
import '/models/user.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late double screenHeight, screenWidth;
  bool remember = false;
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 2.5,
                  width: screenWidth,
                  child: Image.asset('assets/login.png')
                ),
                const Text(
                  "Login",style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5), 
                  child: TextField(
                    controller: emailctrl,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5), 
                  child: TextField(
                    controller: passwordctrl,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(value: remember, onChanged: _onRememberMe),
                      const Text("Remember Me")
                    ],),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: screenWidth,
                        height: 35,
                        child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: _loginUser,
                        )
                      )
                    ,),
                    Padding(
                    padding: EdgeInsets.only(top: 5),),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: screenWidth,
                        height: 35,
                        child: ElevatedButton(
                          child: const Text("Register"),
                          onPressed: _registerUser,
                        )
                      )
                    ,),
                    
              ],)

          )
        ]
      )

    )
    );
  }

  void _onRememberMe(bool? value){
    setState((){
      remember = value!;
    });
  }

  void _loginUser(){
      String _email = emailctrl.text;
      String _password = passwordctrl.text;
      print(_email);
      if (_email.isNotEmpty && _password.isNotEmpty) {
        http.post(Uri.parse("http://10.143.166.152/mytutor/php/login.php"),
            body: {"email": _email, "password": _password}).then((response) {
          var data = jsonDecode(response.body);
          print(data);
          if (response.statusCode == 200 && data['status'] == 'success') {
            User user = User.fromJson(data['data']);
            Fluttertoast.showToast(
                msg: "Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MainScreen(user: user,)));
          } else {
            Fluttertoast.showToast(
                msg: "Failed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        });
      }
    }

    void _registerUser(){
      Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
    }
  }