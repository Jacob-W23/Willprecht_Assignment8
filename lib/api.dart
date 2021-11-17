import 'package:dio/dio.dart';

import './Models/Courses.dart';

const String localhost = "http://10.0.2.2:1250/";

class API {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCourses() async {
    final response = await _dio.get('/getAllCourses');
    return response.data['courses'];
  }

  Future<List> getStudents() async {
    final response = await _dio.get('/getAllStudents');
    return response.data['students'];
  }

  Future editStudent(String id, String newName) async {
    final response = await _dio.post('/editStudent', data: {'id': id, 'fname': newName});
  }

  Future deleteCourse(String id) async {
    final response = await _dio.post('/deleteCourseById', data: {'id': id});
  }
}