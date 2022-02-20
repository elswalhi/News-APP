import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class DioHelper {
  static Dio? dio;
  static init(){
    dio= Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
 static Future<Response?> getData({
    @required String? url,
    @required Map<String, dynamic> ?quary,

  })async{
    return await dio?.get(url!,queryParameters:quary);
  }
}
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=bce0613947e14ce0b67a84a136941f77