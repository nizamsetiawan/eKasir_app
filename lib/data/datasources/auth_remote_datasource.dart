import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekasir_app/core/constants/baseapi.dart';
import 'package:ekasir_app/data/datasources/auth_local_datasource.dart';
import 'package:ekasir_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('$baseUrl/api/logout'),
      headers: {'Authorization': 'Bearer ${authData.token}'},
    );
    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
