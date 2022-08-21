import 'dart:io';
import 'package:dio/dio.dart';
import 'package:latihan_soal/constants/api_url.dart';
import 'package:latihan_soal/helpers/user_email.dart';
import 'package:latihan_soal/models/network_response.dart';

class AuthApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        "x-api-key": ApiUrl.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    return dio;
  }

  Future<Map<String, dynamic>?> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("eror timeout");
        // return NetworkResponse.error(data: null, message: "request timeout");
      }
      print("eror Dio");

      // return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      print("eror Lainnya");
      // return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<Map<String, dynamic>?> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return result.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        print("eror timeout");
        // return NetworkResponse.error(data: null, message: "request timeout");
      }
      print("eror Dio");

      // return NetworkResponse.error(data: null, message: "request error dio");
    } catch (e) {
      print("eror Lainnya");
      // return NetworkResponse.error(data: null, message: "other error");
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail() async {
    final result = await _getRequest(
        endpoint: ApiUrl.users, param: {"email": UserEmail.getUserEmail()});
    return result;
  }

  Future<Map<String, dynamic>?> postRegister(body) async {
    final result = await _postRequest(
      endpoint: ApiUrl.userRegistrasi,
      body: body,
    );
    return result;
  }

  // Future<NetworkResponse> postUpdateUSer(body) async {
  //   final result = await _postRequest(
  //     endpoint: ApiUrl.userUpdateProfile,
  //     body: body,
  //   );
  //   return result;
  // }
}
