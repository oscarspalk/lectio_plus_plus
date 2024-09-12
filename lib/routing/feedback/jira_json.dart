import 'dart:typed_data';

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
