// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userData,
    this.role,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  UserData? userData;
  String? role;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    role: json["role"] == null ? null : json["role"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    expiresIn: json["expires_in"] == null ? null : json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData == null ? null : userData!.toJson(),
    "role": role == null ? null : role,
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "expires_in": expiresIn == null ? null : expiresIn,
  };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.address,
  });

  int? id;
  String? name;
  String? age;
  String? gender;
  String? email;
  String? phone;
  String? address;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
  };
}
