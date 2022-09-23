import 'dart:convert' show json, jsonEncode;
import 'package:cdic_2022/login/register.dart';
import 'package:cdic_2022/menu/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:cdic_2022/network/callAPI.dart';
import 'package:http/http.dart' as http;
import 'package:cdic_2022/login/google_login.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';
import 'User.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _loginPage();

}

class _loginPage extends State<LoginPage>{
  GoogleSignInAccount? _currentUser;

  final _formKey = GlobalKey<FormState>();
  User user = User("", "", "");
  String url = CallAPI().dns + "/user/login";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(json.decode(res.body)["device"]);
    if (res.body != "") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(json.decode(res.body)["device"])), (route) => false);
    }else{
      //todo popup login failed
      print("login failed");
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("로그인 실패"),
              content: SingleChildScrollView(
                child:ListBody(
                  children: <Widget>[
                    Text("로그인에 실패하였습니다."),
                    Text("이메일과 비밀번호를 확인해주세요.")
                  ],
                )
              ),
              actions: <Widget>[
                TextButton(
                  child:Text("확인"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 750,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(1, 5))
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text("Login",
                            style: headingTextStyle,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email",
                            style: titleStyle,
                          ),
                        ),
                        TextFormField(
                          controller: TextEditingController(text: user.email),
                          onChanged: (val) {
                            user.email = val;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Empty';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              errorStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        Container(
                          height: 4,
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: titleStyle,
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller:
                          TextEditingController(text: user.password),
                          onChanged: (val) {
                            user.password = val;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is Empty';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              errorStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        Container(
                          height: 4,
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              "Dont have Account ?",
                              style: titleStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 90,
                  width: 90,
                  child: FlatButton(
                      color: greenColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          save();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            )),
      ),
    );
  }
}