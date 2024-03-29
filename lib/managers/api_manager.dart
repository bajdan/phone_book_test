import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:phone_book_test/utils/json_reader.dart';

import 'exception/app_exceptions.dart';
import 'model/api_request.dart';
import 'model/delete_request.dart';
import 'model/get_request.dart';
import 'model/patch_request.dart';
import 'model/post_request.dart';
import 'model/put_request.dart';

const Duration _requestTimeout = Duration(seconds: 25);

abstract class ApiManager {
  factory ApiManager() => ApiManagerImpl._singleton;

  Future<dynamic> callApiRequest(ApiRequest request);

  Future<dynamic> retry(ApiRequest request);

  static ApiManager of(BuildContext context) => RepositoryProvider.of(context);
}

Map<String, String> globalHeaders = <String, String>{
  'Content-Type': 'application/json'
};

class ApiManagerImpl implements ApiManager {
  String baseUrl = 'https://61ae0f52a7c7f3001786f5b7.mockapi.io/flutter/';
  static final ApiManagerImpl _singleton = ApiManagerImpl._internal();
  final Map<ApiRequest, int> _networkFailedRequestAttempts =
  <ApiRequest, int>{};

  factory ApiManagerImpl() {
    return _singleton;
  }

  ApiManagerImpl._internal();

  @override
  Future<dynamic> callApiRequest(ApiRequest request) async {
    try {
      final dynamic result = await _performRequest(request);
      return result;
    } on SocketException catch (e) {
      // Network error
      final dynamic result = await _handleNetworkError(request, e);
      return result;
    } on TimeoutException catch (e) {
      // Network error
      final dynamic result = await _handleNetworkError(request, e);
      return result;
    }
  }

  Future<dynamic> _performRequest(ApiRequest request) async {
    final Uri url = Uri.parse(baseUrl + request.urlSuffix);
    final Map<String, String> headers = Map<String, String>.of(globalHeaders);

    Future<Response>? responseFuture;
    switch (request.runtimeType) {
      case GetRequest:
        responseFuture = http.get(url, headers: headers);
        break;

      case PostRequest:
        responseFuture = http.post(url,
            body: request.payload.isNotEmpty
                ? json.encode(request.payload)
                : null,
            headers: headers);
        break;

      case PutRequest:
        responseFuture = http.put(url,
            body: request.payload.isNotEmpty
                ? json.encode(request.payload)
                : null,
            headers: headers);
        break;

      case PatchRequest:
        responseFuture = http.patch(url,
            body: json.encode(request.payload), headers: headers);
        break;

      case DeleteRequest:
        responseFuture = http.delete(url, headers: headers);
        break;

      default:
        break;
    }

    final Response response = await responseFuture!.timeout(_requestTimeout);

    if (response.body.contains('403 Forbidden')) {
      throw const SocketException('403 Forbidden');
    }

    _networkFailedRequestAttempts.remove(request);

    return checkResponse(response, request);
  }

  Future<dynamic> _handleNetworkError(ApiRequest request, Exception e) async {
    throw Exception();
  }

  Future<dynamic> checkResponse(Response response, ApiRequest request) async {
    print(
        'Status code ${response.statusCode} for request ${request.urlSuffix}\nBody : \n ${response.body}');

    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
      case 404:
      case 405:
      case 422:
        final JsonReader jsonReader = JsonReader(json.decode(response.body));
        throw BadRequestException(jsonReader['status'].asString(),
            jsonReader['error'].asString(), jsonReader['errors'].asMap());

      case 425:
        final JsonReader jsonReader = JsonReader(json.decode(response.body));
        throw TooEarlyException(
            response.statusCode.toString(), jsonReader['error'].asString());

      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> retry(ApiRequest request) async {
    return Future<dynamic>.delayed(
        const Duration(seconds: 2), () => callApiRequest(request));
  }
}
