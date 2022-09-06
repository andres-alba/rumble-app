import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_page_app/models/login_model.dart';
import 'package:one_page_app/views/one_page.dart';
//import 'dart:convert';

String loginResult = "";

void loginController (String email, String pass, String deviceId) async {
 try{ 
  var headers = {
  'Cookie': 'PHPSESSID=u2aod34bdsmr37jr16kgss2av0'
};
var request = http.MultipartRequest('POST', Uri.parse('https://app-test.rr-qa.seasteaddigital.com/app_api/auth.php'));
request.fields.addAll({
  'device_id': '7789e3ef-c87f-49c5-a2d3-5165927298f0',
  'password': pass,
  'email': email
});

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  var rawData = await response.stream.bytesToString();
  var convertedData = loginFromJson(rawData);
  //print('token ${convertedData.result!.ssAuthToken}');
  
  loginResult = 'OK';
}
else {
  //print(response.reasonPhrase);
  loginResult = 'NO';
}
 }catch(e){
  print('error');
 }
 

  void getFeed(){

  }

}