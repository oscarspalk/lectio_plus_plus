import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:feedback/feedback.dart';

void handleFeedback(UserFeedback feedback) async {
  var url = "https://www.lectioplus.plus/jira";
  var dio = Dio();
  var body = """
  {
    "content": "${feedback.text}",
    "image": "${base64.encode(feedback.screenshot)}"
  }
""";

  await dio.post(url,
      data: body,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      ));
}

class JiraJson {
  String createIssue(String content, Uint8List screenshot) {
    return """
  {
    "fields": {
    "description": {
      "content": [
        {
          "content": [
            {
              "text": "$content",
              "type": "text"
            }
          ],
          "type": "paragraph"
        }
      ],
      "type": "doc",
      "version": 1
    },
        "summary": "App Report"
    },
    "update": {}
  }
""";
  }
}
