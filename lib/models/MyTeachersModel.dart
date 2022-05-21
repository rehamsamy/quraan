class MyTeachersModel {
  MyTeachersModel({
      this.id, 
      this.name, 
      this.age, 
      this.gender, 
      this.salary, 
      this.email, 
      this.phone, 
      this.address, 
      this.pivot,});

  MyTeachersModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    salary = json['salary'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  int? id;
  String? name;
  String? age;
  String? gender;
  dynamic salary;
  String? email;
  String? phone;
  dynamic address;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['salary'] = salary;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}

class Pivot {
  Pivot({
      this.studentId, 
      this.teacherId,});

  Pivot.fromJson(dynamic json) {
    studentId = json['student_id'];
    teacherId = json['teacher_id'];
  }
  String? studentId;
  String? teacherId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = studentId;
    map['teacher_id'] = teacherId;
    return map;
  }

}