// To parse this JSON data, do
//
//     final studentGradesModel = studentGradesModelFromJson(jsonString);

import 'dart:convert';

StudentGradesModel studentGradesModelFromJson(String str) => StudentGradesModel.fromJson(json.decode(str));

String studentGradesModelToJson(StudentGradesModel data) => json.encode(data.toJson());

class StudentGradesModel {
  StudentGradesModel({
    this.id,
    this.grade,
    this.studentId,
    this.teacherId,
    this.sessionId,
    this.surahName,
    this.partNumber,
    this.teacher,
    this.student,
    this.session,
  });

  int? id;
  String? grade;
  String? studentId;
  String? teacherId;
  String? sessionId;
  String? surahName;
  String?partNumber;
  Student? teacher;
  Student? student;
  Session? session;

  factory StudentGradesModel.fromJson(Map<String, dynamic> json) => StudentGradesModel(
    id: json["id"] == null ? null : json["id"],
    grade: json["grade"] == null ? null : json["grade"],
    studentId: json["student_id"] == null ? null : json["student_id"],
    teacherId: json["teacher_id"] == null ? null : json["teacher_id"],
    sessionId: json["session_id"] == null ? null : json["session_id"],
    surahName: json["surah_name"] == null ? null : json["surah_name"],
    partNumber: json["part_number"] == null ? null : json["part_number"],
    teacher: json["teacher"] == null ? null : Student.fromJson(json["teacher"]),
    student: json["student"] == null ? null : Student.fromJson(json["student"]),
    session: json["session"] == null ? null : Session.fromJson(json["session"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "grade": grade == null ? null : grade,
    "student_id": studentId == null ? null : studentId,
    "teacher_id": teacherId == null ? null : teacherId,
    "session_id": sessionId == null ? null : sessionId,
    "surah_name": surahName == null ? null : surahName,
    "part_number": partNumber == null ? null : partNumber,
    "teacher": teacher == null ? null : teacher!.toJson(),
    "student": student == null ? null : student!.toJson(),
    "session": session == null ? null : session!.toJson(),
  };
}

class Session {
  Session({
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
  });

  int? id;
  DateTime? start;
  DateTime? end;
  dynamic type;
  dynamic preSessionId;
  String? status;
  String? teacherId;
  dynamic adminId;
  String? numberOfStudents;
  String? link;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"] == null ? null : json["id"],
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    type: json["type"],
    preSessionId: json["pre_session_id"],
    status: json["status"] == null ? null : json["status"],
    teacherId: json["teacher_id"] == null ? null : json["teacher_id"],
    adminId: json["admin_id"],
    numberOfStudents: json["number_of_students"] == null ? null : json["number_of_students"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "start": start == null ? null : start!.toIso8601String(),
    "end": end == null ? null : end!.toIso8601String(),
    "type": type,
    "pre_session_id": preSessionId,
    "status": status == null ? null : status,
    "teacher_id": teacherId == null ? null : teacherId,
    "admin_id": adminId,
    "number_of_students": numberOfStudents == null ? null : numberOfStudents,
    "link": link == null ? null : link,
  };
}

class Student {
  Student({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.address,
    this.salary,
  });

  int? id;
  String? name;
  String? age;
  String? gender;
  String? email;
  String? phone;
  String? address;
  dynamic salary;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    salary: json["salary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "salary": salary,
  };
}
