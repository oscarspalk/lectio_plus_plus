import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:notify_app/helpers.dart';
import 'package:notify_app/model/lectio_account.dart';
import 'package:notify_app/screens/home.dart';
import 'package:notify_app/types/homework.dart';

const apiUrl = "10.0.2.2";

class LectioServices {
  List<Cookie> cookies = [];

  Future<void> login(LectioAccount lectioAccount) async {
    HttpClient httpClient = HttpClient();
    var postRequest = await httpClient.post(apiUrl, 5000, 'login/');
    postRequest.write(jsonEncode({
      "gymnasiumNumber": lectioAccount.gymId,
      "username": lectioAccount.username,
      "password": lectioAccount.password
    }));
    var response = await postRequest.close();
    cookies = response.cookies;
  }

  Future<List<Homework>> getHomework() async {
    HttpClient httpClient = HttpClient();
    var getRequest = await httpClient.get(apiUrl, 5000, 'lektieListe/');
    getRequest.cookies.addAll(cookies);
    var response = await getRequest.close();
    List<dynamic> homeworkList = jsonDecode(await readResponse(response));
    List<Homework> homework =
        homeworkList.map((json) => Homework(json)).toList();
    return homework;
  }

  Future<dynamic> getSchemaForDate(DateTime date) async {
    int year = date.year;
    int week = (date.day / 7).floor();
    HttpClient httpClient = HttpClient();
    var getRequest =
        await httpClient.get(apiUrl, 5000, 'skema/${year}/${week}/');
    getRequest.cookies.addAll(cookies);
    var response = await getRequest.close();
    return "";
  }
}

Future<Map<String, String>> getGymnasiums() async {
  HttpClient httpClient = HttpClient();
  var getRequest = await httpClient.get(apiUrl, 5000, 'gymnasieListe/');
  var response = await getRequest.close();
  var streng = await readResponse(response);
  print(streng);
  var map = jsonDecode(streng);
  return map;
}
