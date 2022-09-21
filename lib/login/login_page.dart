import 'dart:convert' show json, jsonEncode;
import 'package:cdic_2022/menu/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:cdic_2022/network/callAPI.dart';
import 'package:http/http.dart' as http;
import 'package:cdic_2022/login/google_login.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _loginPage();

}

class _loginPage extends State<LoginPage>{
  GoogleSignInAccount? _currentUser;
  String model = "";
  String androidId = "";
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _asyncCheck();
  }

  _asyncCheck() async{
    String id="";
    try{
      id = await storage.read(key: 'id')??"";
    }catch(e){
      print(e);
      return;
    }
    if(id==""){
      return;
    }
    Map<String, dynamic> map = {};
    map['user_gmail_id'] = id; //이메일 앞글자만 보내기
    map['gmail_id'] = id; //이메일 앞글자만 보내기
    map['android_id'] = androidId; //이메일 앞글자만 보내기
    map['device_model'] = model; //이메일 앞글자만 보내기
    CallAPI post = CallAPI();
    try {
      //todo server url change
      var test = await post.RequestHttp('/user/account/logout', json.encode(map));
      var response = await post.RequestHttp('/user/account/login', json.encode(map));
      var result = response['result'];


      loginAfter(id, result);
    }catch(e){
      Get.dialog(AlertDialog(
        title: const Text('오류'),
        content: const Text('서버와의 연결이 끊겼습니다.'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("닫기"))
        ],
      ));
    }

  }

  Future<void> loginAfter(String email, dynamic result) async {
    if (result['code'] == 'success') {
      await storage.write(key: 'id', value: email);
      await storage.write(key: 'nick', value: result['nick']);

      //login success
      Get.dialog(AlertDialog(
        title: const Text('성공'),
        content: const Text('로그인 성공'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.off(() => ProfilePage());
              },
              child: const Text("닫기"))
        ],
      ),barrierDismissible: false);
    } else if (result['code'] == "signup") {
      //user 계정이 없는 경우.
      await logout();
      Get.toNamed('/signup', arguments: email);
    } else if (result['code'] == "logedin") {
      //이미 로그인한경우
      //TODO 후에 서logout버에서 연결을 취소하고, 여기선 로그아웃 후 로그인을 보낸다(다이얼로그로 확인 요망)
      //지금은 임시로 성공이라고하겠다

      CallAPI post = CallAPI();
      var map = <String,dynamic>{};
      map['gmail_id'] = email;
      map['user_gmail_id'] = email;
      try {
        await post.RequestHttp('/user/account/logout', json.encode(map));
        await post.RequestHttp('/user/account/login', json.encode(map));
        await storage.write(key: 'id', value: email);
        Get.dialog(
            AlertDialog(
              title: const Text('성공'),
              content: const Text('로그인 성공'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                      Get.off(() => ProfilePage());
                    },
                    child: const Text("닫기"))
              ],
            ),barrierDismissible: false);
      }catch(e){
        Get.dialog(AlertDialog(
          title: const Text('오류'),
          content: const Text('서버와의 연결이 끊겼습니다'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("닫기"))
          ],
        ));
      }


    } else {
      Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('로그인이 제대로 되지 않았습니다\n다시 시도 부탁드립니다.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("닫기"))
        ],
      ));
    }
  }


  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in Failed')));
    } else {
      setState(() {
        _currentUser = user;
      });
      /*
        로그인 성공 시 작업.
       */
      String email = user.email.split('@')[0];
      Map<String, dynamic> map = {};
      map['user_gmail_id'] = email; //이메일 앞글자만 보내기
      map['gmail_id'] = email; //이메일 앞글자만 보내기
      map['android_id'] = androidId; //이메일 앞글자만 보내기
      map['device_model'] = model; //이메일 앞글자만 보내기
      CallAPI post = CallAPI();
      try {
        //todo server url change
        await post.RequestHttp('/user/account/logout', json.encode(map));
        var response = await post.RequestHttp('/user/account/login', json.encode(map));
        var result = response['result'];
        loginAfter(email, result);
      }catch(e){
        Get.dialog(AlertDialog(
          title: const Text('오류'),
          content: const Text('서버와의 연결이 끊겼습니다'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("닫기"))
          ],
        ));
      }
    }
  }

  Future logout() async {
    await GoogleSignInApi.logout();
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomBar(1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen.shade400,
                            Colors.greenAccent,
                            Colors.teal.shade400,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '구글 계정으로 로그인 및 회원가입을 진행해 주세요.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.off(()=>ProfilePage());
                            },// async => await signIn(),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              elevation: MaterialStateProperty.all(2),
                              overlayColor:
                              MaterialStateProperty.all(Colors.black12),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.green.shade50),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),

                            ),
                            child: Row(
                              children: const [
                                // Expanded(child:ImageIcon(
                                //   AssetImage('asset/icons/googleLogo.png'),
                                //   size: 10,
                                //   color: Colors.black87,
                                // ),),
                                Spacer(),
                                Text(
                                  'Sign In with Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}