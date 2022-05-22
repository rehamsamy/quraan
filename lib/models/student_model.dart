// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.address,
    this.number_of_parts
  });

  int? id;
  String? name;
  String? age;
  String? gender;
  String? email;
  String? phone;
  String? address;
  String ? number_of_parts;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    number_of_parts: json["number_of_parts"] == null ? null : json["number_of_parts"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "number_of_parts": number_of_parts == null ? null : number_of_parts,
  };
}
