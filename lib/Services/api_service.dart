
import 'dart:io';
import 'package:dio/dio.dart';

import '../Model/province_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      //  "http://127.0.0.1:8000/api", //chrome
      baseUrl: "http://10.0.2.2:8000/api",  //emulator
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  Future<Response> login(String phone, String password) async {
   return await dio.post(
      "/login",
      data: {
        "phone": phone,
        "password": password,
      },
    );

  }



  Future<Response> signUp({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phone,
    required String password,
    File? avatar,
  }) async {
    FormData formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "phone": phone,
      "password": password,
      if (avatar != null)
        "avatar": await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        ),
    });

    return dio.post(
      "/register",
      data: formData,
        options: Options(contentType: 'multipart/form-data')
    );
  }




  Future<List<Province>> getProvinces() async {
    try {
      final response = await dio.get('/provinces');

      // الوصول للـ data
      final List provincesJson = response.data['data'];

      // تحويل JSON → List<Province>
      return provincesJson
          .map((json) => Province.fromJson(json))
          .toList();
    } catch (e) {
      print('❌ Error fetching provinces: $e');
      return [];
    }
  }
}
