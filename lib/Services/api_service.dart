import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/Model/booking_model.dart';

import '../Model/apartment_model.dart';
import '../Model/province_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api", //emulator
      headers: {"Accept": "application/json"},
    ),
  );

  //storing the token
  final box = GetStorage();
  late final token = box.read('token');

  //---------------------------------------------------------------------------
  Future<Response> login(String phone, String password) async {
    return await dio.post(
      "/login",
      data: {"phone": phone, "password": password},
    );
  }

  //-----------------------------------------------------------------------------
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
    return dio.post("/register", data: formData);
  }

  //-----------------------------------------------------------------------
  Future<List<Province>> getProvinces() async {
    try {
      final response = await dio.get('/provinces');

      // الوصول للـ data
      final List provincesJson = response.data['data'];

      // تحويل JSON → List<Province>
      return provincesJson.map((json) => Province.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error fetching provinces: $e');
      return [];
    }
  }

  //----------------------------------------------------------------------------------
  Future<List<Apartment>> getApartments() async {
    try {
      // print('The token is : $token');
      final response = await dio.get(
        '/properties/showAll',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List apartmentsJson = response.data['properties'];

      return apartmentsJson.map((json) => Apartment.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error fetching Apartments: $e');
      return [];
    }
  }

  //---------------------------------------------------------------------------
  Future<Booking> booking(String start_date, String end_date, int id) async {
    try {
      final response = await dio.post(
        '/book/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"start_date": start_date, "end_date": end_date},
      );

      return Booking.fromJson(response.data['booking']);
    } catch (e) {
      e.toString();
      print("the bath is  ${dio.options.baseUrl} + '/book/$id'");
      print('❌ Error booking : $e');
      rethrow;
    }
  }

  //---------------------------------------------------------------------------
  Future<List<BookingRange>> fetchApartmentBookings(int apartmentId) async {
    try {
      final response = await dio.get(
        '/showAllBookingsForOneProperty/$apartmentId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List ApartmentBookingsJson = response.data['data'];

      return ApartmentBookingsJson.map(
        (json) => BookingRange.fromJson(json),
      ).toList();
    } catch (e) {
      print('❌ Error fetching Apartments Bookings : $e');
      return [];
    }
  }
}
