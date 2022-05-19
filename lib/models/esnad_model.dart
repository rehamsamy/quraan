class EsnadModel {
  EsnadModel({
      this.id, 
      this.teacherId, 
      this.studentId, 
      this.teacherName, 
      this.studentName, 
      this.teacher, 
      this.student,});

  EsnadModel.fromJson(dynamic json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
    teacherName = json['teacher_name'];
    studentName = json['student_name'];
    teacher = json['teacher'] != null ? EsnadTeacher .fromJson(json['teacher']) : null;
    student = json['student'] != null ? EsnadStudent.fromJson(json['student']) : null;
  }
  int? id;
  String? teacherId;
  String? studentId;
  String? teacherName;
  String? studentName;
  EsnadTeacher? teacher;
  EsnadStudent? student;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['teacher_id'] = teacherId;
    map['student_id'] = studentId;
    map['teacher_name'] = teacherName;
    map['student_name'] = studentName;
    if (teacher != null) {
      map['teacher'] = teacher?.toJson();
    }
    if (student != null) {
      map['student'] = student?.toJson();
    }
    return map;
  }

}

class EsnadStudent {
  EsnadStudent({
      this.id, 
      this.name, 
      this.age, 
      this.gender, 
      this.email, 
      this.phone, 
      this.address, 
      this.numberOfParts,});

  EsnadStudent.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    numberOfParts = json['number_of_parts'];
  }
  int? id;
  String? name;
  String? age;
  String? gender;
  String? email;
  String? phone;
  String? address;
  String? numberOfParts;

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
    return map;
  }

}

class EsnadTeacher {
  EsnadTeacher({
      this.id, 
      this.name, 
      this.age, 
      this.gender, 
      this.salary, 
      this.email, 
      this.phone, 
      this.address,});

  EsnadTeacher.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    salary = json['salary'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }
  int? id;
  String? name;
  String? age;
  String? gender;
  dynamic salary;
  String? email;
  String? phone;
  dynamic address;

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
    return map;
  }

}