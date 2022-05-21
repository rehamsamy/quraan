class MyStudentsModel {
  MyStudentsModel({
      this.id, 
      this.name, 
      this.age, 
      this.gender, 
      this.email, 
      this.phone, 
      this.address, 
      this.numberOfParts, 
      this.pivot,});

  MyStudentsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    numberOfParts = json['number_of_parts'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  int? id;
  String? name;
  String? age;
  String? gender;
  String? email;
  String? phone;
  String? address;
  String? numberOfParts;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['number_of_parts'] = numberOfParts;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}

class Pivot {
  Pivot({
      this.teacherId, 
      this.studentId,});

  Pivot.fromJson(dynamic json) {
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
  }
  String? teacherId;
  String? studentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['teacher_id'] = teacherId;
    map['student_id'] = studentId;
    return map;
  }

}