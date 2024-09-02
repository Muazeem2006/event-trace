// ignore_for_file: avoid_log
import 'dart:developer';

import 'package:dio/dio.dart';

const host = "192.168.0.101"; // connected


const port = "8000";
const url = "http://$host:$port";
const baseUrl = "$url/api";
Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
  'Accept': 'application/json',
}));

Future<Response> getRequest(String url,
    [dynamic data, Map<String, dynamic>? headers]) async {
  url = "$baseUrl/$url";
  log('GET: $url');
  final response = await dio.get(url,
      queryParameters: data, options: Options(headers: headers));
  log(response.data.toString());
  return response;
}

Future<Response> postRequest(String url,
    [dynamic data, Map<String, dynamic>? headers]) async {
  url = "$baseUrl/$url";
  log('POST: $url');
  final response =
      await dio.post(url, data: data, options: Options(headers: headers));
  log(response.data.toString());
  return response;
}

Future<Response> putRequest(String url,
    [dynamic data, Map<String, dynamic>? headers]) async {
  url = "$baseUrl/$url";
  log('PUT: $url');
  final response =
      await dio.put(url, data: data, options: Options(headers: headers));
  log(response.data.toString());
  return response;
}

Future<Response> deleteRequest(String url,
    [dynamic data, Map<String, dynamic>? headers]) async {
  url = "$baseUrl/$url";
  log('DELETE: $url');
  final response =
      await dio.delete(url, data: data, options: Options(headers: headers));
  log(response.data.toString());
  return response;
}
