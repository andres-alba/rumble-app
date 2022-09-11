import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:one_page_app/models/feed_model.dart';
import 'package:one_page_app/models/login_model.dart';
//import 'dart:convert';

String loginResult = "";
String bearerToken = "";

void loginController(String email, String pass, String deviceId) async {
  try {
    var headers = {'Cookie': 'PHPSESSID=u2aod34bdsmr37jr16kgss2av0'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://app-test.rr-qa.seasteaddigital.com/app_api/auth.php'));
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
      bearerToken = convertedData.result!.ssAuthToken.toString();
      //print('token ${convertedData.result!.ssAuthToken}');

      loginResult = 'OK';
    } else {
      //print(response.reasonPhrase);
      loginResult = 'NO';
    }
  } catch (e) {
    print('error');
  }
}

Future<Feed> getFeed(
    {int pageSize = 10,
    required int lastPostId,
    String order = "recent"}) async {
  try {
    var headers = {
      'X-APP-AUTH-TOKEN': bearerToken,
      'X-DEVICE-ID': '7789e3ef-c87f-49c5-a2d3-5165927298f0',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://app-test.rr-qa.seasteaddigital.com/api/v1/posts/feed/global.json'));
    request.body = json.encode({
      "data": {"page_size": pageSize, "order": order, "lpid": lastPostId}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var rawFeed = await response.stream.bytesToString();
      var decodedData = feedFromJson(rawFeed);

      print(decodedData.data!.length);

      return decodedData;
    } else {}
  } catch (e) {
    print('catch');
  }
  return Feed();
}
