class Homework {
  String dato;
  String activity;
  String note;
  String homework;
  String classLink;
  String homeworkLink;

  Homework(dynamic json)
      : dato = json['Dato'],
        activity = json['Aktivitet'],
        note = json['Note'],
        homework = json['Lektier'],
        classLink = json['Time-link'],
        homeworkLink = json['Lektie-link'];
}
