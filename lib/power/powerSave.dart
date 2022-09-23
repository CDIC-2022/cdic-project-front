import 'dart:convert' show json;

import 'package:cdic_2022/network/callAPI.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class powerSave{

  Future<int> isPowerSaved(String deviceName) async {
    String urlSaved = "/power/checkOnOff";

    var res = await http.post(Uri.parse(CallAPI().dns + urlSaved),
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

  Future<bool> powerSaveOn(String deviceName) async {
    String urlOn = "/power/powerSaveOn";
    print("on");
    var res = await http.post(Uri.parse(CallAPI().dns + urlOn),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body == "true"){
      return true;
    }else{
      print("connection error occur");
      return false;
    }
  }

  Future<bool> powerSaveOff(String deviceName) async {
    String urlOff = "/power/powerSaveOff";
    print("off");
    var res = await http.post(Uri.parse(CallAPI().dns + urlOff),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body == "true"){
      return false;
    }else{
      print("Connection error occur");
      return true;
    }

  }

  Future<String> dayReduceW(String deviceName) async{
    String urlDayRW = "/power/dayReduceW";
    print("day reduce power save");
    var res = await http.post(Uri.parse(CallAPI().dns + urlDayRW),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> monthReduceW(String deviceName) async{
    String urlMonthRW = "/power/monthReduceW";
    print("month reduce power save");
    var res = await http.post(Uri.parse(CallAPI().dns + urlMonthRW),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> monthPayment(String deviceName) async{
    String urlMonthPay = "/power/monthPayment";
    print("month payment");
    var res = await http.post(Uri.parse(CallAPI().dns + urlMonthPay),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> expectReduceW(String deviceName) async{
    String urlExpectPay = "/power/expectReduceW";
    print("expect reduce power");
    var res = await http.post(Uri.parse(CallAPI().dns + urlExpectPay),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'device' : deviceName})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }
}