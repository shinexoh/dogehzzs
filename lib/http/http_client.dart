import 'dart:io';
import 'package:dio/dio.dart';

import '../util/util.dart';

class HttpClient {
  static HttpClient? _instance;

  static late Dio _dio;

  HttpClient._() {
    _dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8)));
  }

  static HttpClient getInstance() => _instance ??= HttpClient._();

  static Future<HttpData> get(String url) async {
    prints('开始请求：$url');
    Response response;
    try {
      response = await _dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        prints('请求成功：${response.statusCode}');
        return HttpData(isOk: true, data: response.data);
      } else {
        prints('请求失败：${response.statusCode}');
        return HttpData(
            isOk: false, errorMsg: '请求失败，状态码：${response.statusCode}');
      }
    } catch (e) {
      prints('捕抓到错误');
      return HttpData(isOk: false, errorMsg: '请求错误：$e');
    }
  }
}

class HttpData {
  bool isOk;
  dynamic data;
  String? errorMsg;

  HttpData({
    required this.isOk,
    this.data,
    this.errorMsg,
  });
}
