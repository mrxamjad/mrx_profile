// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SkillsData {
  String id;
  final String title;
  final String desc;

  SkillsData({
    this.id = "",
    required this.title,
    required this.desc,
  });

  Map<String, dynamic> toJson() => {"id": id, "title": title, "desc": desc};

  static SkillsData fromJson(Map<String, dynamic> json) =>
      SkillsData(id: json['id'], title: json['title'], desc: json['desc']);
}
