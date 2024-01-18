import 'package:ekasir_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toRawJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authdata = prefs.getString('auth_data');
    return AuthResponseModel.fromRawJson(authdata!);
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authdata = prefs.getString('auth_data');
    return authdata != null;
  }
}
