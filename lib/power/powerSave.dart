import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class powerSave{

  Future<int> isPowerSaved(String deviceName) async {
    String url = "http://192.168.1.30:8080/power/checkOnOff";
    print("sent to /power/checkOnOff");
    var res = await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'device' : deviceName})
    );

    if(res.body == "true"){
      return 1;
    }else if (res.body == "false"){
      return 0;
    }else{
      print("Connection Error");
      return -1;

    }
  }

  bool powerSaveOn(){
    print("on");

    return true;
  }

  bool powerSaveOff(){
    print("off");
    return false;
  }
}