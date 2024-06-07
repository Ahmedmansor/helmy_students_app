import 'dart:core';

class StudentModel {
  List<Students>? students;

  StudentModel({this.students});

  StudentModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  int? id;
  String? studentId;
  String? name;
  String? studentImage;
  int? year;
  String? className;
  String? createdAt;
  String? updatedAt;

  Students(
      {this.id,
      this.studentId,
      this.name,
      this.studentImage,
      this.year,
      this.className,
      this.createdAt,
      this.updatedAt});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    name = json['name'];
    studentImage = json['studentImage'];
    year = json['year'];
    className = json['className'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['name'] = this.name;
    data['studentImage'] = this.studentImage;
    data['year'] = this.year;
    data['className'] = this.className;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
