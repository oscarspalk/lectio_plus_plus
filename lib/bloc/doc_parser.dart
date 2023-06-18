class DocParser {
  static Map<String, String> fromString(String data) {
    Map<String, String> map = {};
    var list = data.split("\n");
    for (var entry in list) {
      if (entry.isNotEmpty) {
        var entryList = entry.split("=");
        map.putIfAbsent(entryList[0], () => entryList[1]);
      }
    }
    return map;
  }

  static String fromMap(Map<String, String> map) {
    String data = "";
    for (var entry in map.entries) {
      data = "${entry.key}=${entry.value}\n$data";
    }
    return data;
  }
}
