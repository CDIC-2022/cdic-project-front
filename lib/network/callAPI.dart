import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CallAPI{

  final String dns = "http://52.193.171.134:8080";

  /*
    uri : /없이 주소 넣기
    map : Map형식으로 데이터 넣기
    post형태로 보냅니다
    call하는 대에선 await해서 받아줍니다
   */
Future<dynamic> RequestHttp(uri, map) async{
    uri = dns+uri;
    try {
      var response = await http
          .post(Uri.parse(uri),
          headers: {"Content-Type": "application/json"}, body: map)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw Exception('네트워크 접속 지연');

      });
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        print(uri);
        print(statusCode);
        print('통신 오류 statusCode 확인 부탁');
      }
      return json.decode(utf8.decode(response.bodyBytes));
    }catch(e){
      Exception(e);
    }
  }

  /*
    uri : /없이 주소 넣기
    gett형태로 보냅니다
    call하는 대에선 await해서 받아줍니다
   */
  Future<http.Response> ResponseGetHttp(uri) async{
    uri = dns+uri;
    var response = await http.get(Uri.parse(uri)); // 통신
    // print('statusCode : ${response.statusCode}');
    // print('header : ${response.headers}');
    // print('body : ${response.body}');
    return response;
  }

}