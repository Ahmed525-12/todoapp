import 'dart:convert';

class Task {
  String id;
  String title;
  String desc;
  int date;
  bool isDone;
  Task(
      {this.id = "",
      required this.title,
      required this.desc,
      required this.date,
      this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "date": date,
      "isDone": isDone
    };
  }

  Task.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"] as String,
            title: json["title"] as String,
            desc: json["desc"],
            date: json["date"] as int,
            isDone: json["isDone"] as bool);
}
