import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
      ),
    );
  }


  static Future<Response<dynamic>?> getData({
        @required String? url,
        Map<String, dynamic>? queryParameters,
        String? token,
      }) async {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang" : "en",
      "Authorization" : token,
    };
    return await dio?.get(
      url!,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>?> postData({
    @required String? url,
    Map<String, dynamic>? queryParameters,
    @required Map<String, dynamic>? data
  }) async {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang" : "en",
    };
    return await dio?.post(
      url!,
      queryParameters: queryParameters,
      data: data,
    );
  }





}

