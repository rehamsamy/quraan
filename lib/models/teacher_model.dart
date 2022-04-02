// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

import 'dart:convert';

TeacherModel teacherModelFromJson(String str) => TeacherModel.fromJson(json.decode(str));

String teacherModelToJson(TeacherModel data) => json.encode(data.toJson());

class TeacherModel {
  TeacherModel({
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

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
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
