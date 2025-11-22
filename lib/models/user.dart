import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginResult {
  final bool isSuccess;
  final String? errorMessage;
  final User? user; // يمكن أن يحتوي على بيانات المستخدم عند النجاح

  LoginResult({required this.isSuccess, this.errorMessage, this.user});
}

// تعريفات فئات البيانات (تم استبدال التعريفات الوهمية بتعريفاتك الكاملة)
class User {
// ... (محتويات فئة User كما هي)
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  String? gender;
  String? image;

  User({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.gender,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'gender': gender,
      'image': image,
    };
  }
}

class UserResponse {
// ... (محتويات فئة UserResponse كما هي)
  bool? status;
  String? message;
  User? user;
  String? token;

  UserResponse({this.status, this.message, this.user, this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
