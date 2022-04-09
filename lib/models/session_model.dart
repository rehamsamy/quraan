// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);

import 'dart:convert';

SessionModel sessionModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  SessionModel({
    this.id,
    this.start,
    this.end,
    this.type,
    this.preSessionId,
    this.status,
    this.teacherId,
    this.adminId,
    this.numberOfStudents,
    this.link,
    this.teacher,
  });

  int? id;
  DateTime? start;
  DateTime? end;
  dynamic type;
  dynamic preSessionId;
  String? status;
  String? teacherId;
  String? adminId;
  String? numberOfStudents;
  String? link;
  Teacher? teacher;

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    id: json["id"] == null ? null : json["id"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    type: json["type"],
    preSessionId: json["pre_session_id"],
    status: json["status"] == null ? null : json["status"],
    teacherId: json["teacher_id"] == null ? null : json["teacher_id"],
    adminId: json["admin_id"] == null ? null : json["admin_id"],
    numberOfStudents: json["number_of_students"] == null ? null : json["number_of_students"],
    link: json["link"] == null ? null : json["link"],
    teacher: json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "start": start == null ? null : start!.toIso8601String(),
    "end": end == null ? null : end!.toIso8601String(),
    "type": type,
    "pre_session_id": preSessionId,
    "status": status == null ? null : status,
    "teacher_id": teacherId == null ? null : teacherId,
    "admin_id": adminId == null ? null : adminId,
    "number_of_students": numberOfStudents == null ? null : numberOfStudents,
    "link": link == null ? null : link,
    "teacher": teacher == null ? null : teacher!.toJson(),
  };
}

class Teacher {
  Teacher({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.salary,
    this.email,
    this.phone,
    this.address,
  });

  int? id;
  String? name;
  String? age;
  String? gender;
  dynamic salary;
  String? email;
  String? phone;
  dynamic address;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    salary: json["salary"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "salary": salary,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "address": address,
  };
}
