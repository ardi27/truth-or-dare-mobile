import 'dart:async';

import 'package:dio/dio.dart';
import 'package:truthordare/constants/ErrorException.dart';
import 'package:truthordare/constants/SharedPreferenceKey.dart';

import 'package:truthordare/utilities/secure_store.dart';

import 'SharedPreferences.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  @override
  Future<FutureOr> onRequest(RequestOptions options) async {

    print(options.headers.containsKey("requireToken"));
    if(options.headers.containsKey("requireToken")){
      options.headers.remove('requireToken');
      String token = await SecureStore().readValue(key: "token");
      print(token);
      options.headers.addAll({
        "Authorization":"Bearer $token"
      });
    }
    return options;
  }

  @override
  Future<FutureOr> onError(DioError dioError) async {
    // logging
    print(
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("<-- End error");

    await Preferences.setDataBool(kIsRefresh, false);

    // if (dioError.response?.statusCode == 401) {
    // dio.interceptors.requestLock.lock();
    // dio.interceptors.responseLock.lock();

    // AuthenticationRepository authenticationRepository =
    //     AuthenticationRepository();

    // TokenModel refreshToken = await authenticationRepository.refreshToken();

    // if (refreshToken != null) {
    //   // get new access token
    //   String token = await SecureStore().readValue(key: kAccessTokenKey);
    //   RequestOptions options = dioError.response.request;
    //   options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;

    //   // dio.interceptors.requestLock.unlock();
    //   // dio.interceptors.responseLock.unlock();

    //   return dio.request(options.path, options: options);
    // } else {
    // return dioError;
    // }
    // }
    if (dioError.response?.statusCode == 401) {
      // final data = dioError.response.data;
      // throw Exception(data['error_description']);
      throw Exception(ErrorException.unauthorizedException);
    } else if (dioError.response?.statusCode == 408) {
      throw Exception(ErrorException.timeoutException);
    } else if (dioError.response?.statusCode == 404) {
      final data = dioError.response.data;
      throw Exception(data['results']??data['message']);
    } else if (dioError.response?.statusCode == 422) {
      final data = dioError.response.data;
      throw Exception(data['results']??data['message']);
    } else if (dioError.response?.statusCode == 417) {
      final data = dioError.response.data;
      throw Exception(data['results']??data['message']);
    }else {
      throw Exception(dioError.message);
    }

    // if (dioError.response?.statusCode == 400) {
    //   final response = dioError.response?.data;
    //   final errorMessage = response['error'];

    //   if (errorMessage == ErrorException.invalidGrant) {
    //     // delete all storages
    //     await SecureStore().deleteAll();

    //     navService.pushNamed(kLoginRoute,
    //         args: 'Session Anda habis, silahkan Login kembali');
    //   }
    // }
  }

  @override
  Future<FutureOr> onResponse(Response response) async {
    print(
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    // get respon header
    // print("Headers:");
    // response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
  }
}
