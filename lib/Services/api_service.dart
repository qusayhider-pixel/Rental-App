import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/Model/booking_model.dart';
import '../Model/Reservation_model.dart';
import '../Model/apartment_model.dart';
import '../Model/province_model.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api", //emulator
      // baseUrl: "http://127.0.0.1:8000/api", //chrome
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
  Future<Response> signUp({required String firstName, required String lastName, required String dateOfBirth, required String phone, required String password, File? avatar,}) async {
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

      final List provincesJson = response.data['data'];

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

      return ApartmentBookingsJson
          .map((json) => BookingRange.fromJson(json),)
          .toList();
    } catch (e) {
      print('❌ Error fetching Apartments Bookings : $e');
      return [];
    }
  }

  //---------------------------------------------------------------------------
  Future<List<BookingRange>> fetchingForEditingRanges(int apartmentId,
      int bookId) async {
    try {
      final response = await dio.get(
        '/showAllBookingsForOnePropertyWithoutOne/$apartmentId/$bookId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List ApartmentBookingsJson = response.data['data'];

      return ApartmentBookingsJson
          .map((json) => BookingRange.fromJson(json),)
          .toList();
    } catch (e) {
      print(
          '❌ Error fetching Apartments other Bookings without one booking : $e');
      return [];
    }
  }

  //----------------------------------------------------------------------------
  Future<int?> uploadApartment({required Map<String, dynamic> data, required List<File?> images,}) async {
    try {
      FormData formData = FormData.fromMap(data);

      for (var file in images) {
        if (file != null) {
          formData.files.add(
            MapEntry(
              'images[]',
              await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              ),
            ),
          );
        }
      }

      final response = await dio.post(
        '/properties/add',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print("Response : ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['id'] ?? response.data['property']['id'];
      }
    } catch (e) {
      print('❌ Error Uploading: $e');
      return null;
    }
    return null;
  }

  //----------------------------------------------------------------------------
  Future<List<Reservation>> fetchReservationRequests() async {
    try
        {
          final response = await dio.get('/owner/Dashboard' ,
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
          final List reservationJson = response.data['data'];

          return reservationJson.map((json) => Reservation.fromJson(json)).toList();
        }

    catch(e)
    {
      print(e.toString());
      return[];
    }
  }

  //----------------------------------------------------------------------------
  Future<void> updateReservatoinRequestStatus (String status , int requestID )async{
    try{
      final response = await dio.put('/owner/updateRequestStatus/$requestID',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'bookings_status_check': status},
      );
      // return ReservationStatus.fromJson(response.data) ;
    }
    catch(e)
    {
      e.toString();
      print("the bath is  ${dio.options
          .baseUrl}'/owner/updateRequestStatus/$requestID'");
      print('❌ Error booking : $e');
      rethrow;
    }
  }

  //----------------------------------------------------------------------------
  Future<List<MyReservations>> fetchingMyReservations() async {
    try {
      final response = await dio.get('/getTenantBookings',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final List myReservations = response.data['data'];

      return myReservations
          .map((json) => MyReservations.fromJson(json))
          .toList();
    }
    catch (e) {
      e.toString();
      print("the bath is  ${dio.options.baseUrl}/getTenantBookings");
      print('❌ Error booking : $e');
      rethrow;
    }
  }

  //----------------------------------------------------------------------------
  Future<void> editngBookingDates(String startDate, String endDate,
      int id) async {
    try {
      await dio.put('/editBooking/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"start_date": startDate, "end_date": endDate},
      );
    } catch (e) {
      e.toString();
      print("the bath is  ${dio.options.baseUrl}/editBooking/$id'");
      print('❌ Error edit booking\'s Dates : $e');
      rethrow;
    }
  }

  //----------------------------------------------------------------------------
  Future<void> cancelingABooking(int id) async {
    try {
      await dio.post('/cancelBooking/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      e.toString();
      print("the bath is  ${dio.options.baseUrl}/cancelBooking/$id'");
      print('❌ Error canceling booking : $e');
      rethrow;
    }
  }

//-----------------------------------------------------------------------------

}
