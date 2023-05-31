import 'package:fic4_tugas_akhir_ekatalog/data/models/response/login_response_model.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/models/response/profile_response_model.dart';

import '../localsources/auth_local_storage.dart';
import '../models/request/login_model.dart';
import '../models/request/register_model.dart';
import '../models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasource {
  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      body: registerModel.toMap(),
    );

    final result = RegisterResponseModel.fromJson(response.body);
    return result;
  }

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: loginModel.toMap(),
    );

    final result = LoginResponseModel.fromJson(response.body);
    return result;
  }

  Future<ProfileResponseModel> getProfile() async {
    final token = await AuthLocalStorage().getToken();
    var header = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
      headers: header,
    );

    final result = ProfileResponseModel.fromJson(response.body);
    return result;
  }
}
