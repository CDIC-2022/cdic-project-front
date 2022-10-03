import 'dart:convert' show json;

import 'package:cdic_2022/network/callAPI.dart';
import 'package:flutter/material.dart';
import 'package:get_mac/get_mac.dart';
import 'package:http/http.dart' as http;

class powerSave{
  String macAddr = "11:22:33:44:55:66";

  Future<int> isPowerSaved() async {
    String urlSaved = "/arduino/checkOnOff";

    var res = await http.post(Uri.parse(CallAPI().dns + urlSaved),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'MAC' : macAddr})
    );

    if(res.body == "1"){
      return 1;
    }else if (res.body == "0"){
      return 0;
    }else{
      print("Connection Error");
      return -1;
    }
  }

  Future<bool> powerSaveOn() async {
    String urlOn = "/arduino/restoreOnOff";
    print("on");
    var res = await http.post(Uri.parse(CallAPI().dns + urlOn),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body == "1"){
      return true;
    }else{
      print("connection error occur");
      print(res.body + "error ");
      return false;
    }
  }

  Future<bool> powerSaveOff() async {
    String urlOff = "/arduino/restoreOnOff";
    print("off");
    var res = await http.post(Uri.parse(CallAPI().dns + urlOff),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body == "1"){
      return false;
    }else{
      print("connection error occur");
      print(res.body + "error ");
      return true;
    }

  }

  Future<String> dayReduceW() async{
    String urlDayRW = "/arduino/dayWatt";
    print("day reduce power save");
    var res = await http.post(Uri.parse(CallAPI().dns + urlDayRW),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> monthReduceW() async{
    String urlMonthRW = "/arduino/monthWatt";
    print("month reduce power save");
    var res = await http.post(Uri.parse(CallAPI().dns + urlMonthRW),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> monthPayment() async{
    String urlMonthPay = "/arduino/monthPayment";
    print("month payment");
    var res = await http.post(Uri.parse(CallAPI().dns + urlMonthPay),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }

  Future<String> expectReduceW() async{
    String urlExpectPay = "/arduino/expectWatt";
    print("expect reduce power");
    var res = await http.post(Uri.parse(CallAPI().dns + urlExpectPay),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'MAC' : macAddr})
    );

    if(res.body != ""){
      return res.body;
    }else{
      return "0";
    }
  }
}