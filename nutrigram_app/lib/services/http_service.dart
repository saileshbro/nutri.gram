import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class HttpService {
  final _logger = getLogger("HttpService");
  final String _baseUrl = "${kBaseUrl}api/v1";
  final UserDataService _userDataService;
  HttpService(this._userDataService);

  Map<String, String> get _defaultHeader => {
        'Authorization': 'Bearer ${_userDataService.token}',
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json, text/plain, */*',
        HttpHeaders.userAgentHeader: "",
      };

  ///
  /// Http [GET] method.
  /// Method Params:
  /// [path] = URL path after [kBaseUrl]
  /// Return type: [Stream]
  ///
  Stream get({@required String url}) {
    _logger.d("GET request to $_baseUrl/$url");
    return Stream.fromFuture(http.get(
      '$_baseUrl/$url',
      headers: _defaultHeader,
    )).flatMap((_) {
      if (_.statusCode >= 400) {
        _logger.e(jsonDecode(_.body)["error"]);
        throw Failure(
          message: jsonDecode(_.body)["error"],
        );
      } else {
        return Stream.value(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [POST] method.
  /// Method Params:
  /// [url] = URL path after [kBaseUrl]
  /// [encodedJson] = json body
  /// Return type: [Stream]
  ///
  Stream post({@required String url, @required String encodedJson}) {
    _logger.d("POST request to $_baseUrl/$url");
    return Stream.fromFuture(http.post(
      '$_baseUrl/$url',
      headers: _defaultHeader,
      body: encodedJson,
    )).flatMap((data) {
      if (data.statusCode >= 400) {
        _logger.e(jsonDecode(data.body)["error"]);
        throw Failure(
          statusCode: data.statusCode,
          message: jsonDecode(data.body)["error"],
        );
      } else {
        return Stream.value(data);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [PUT] method.
  /// Method Params:
  /// [url] = URL path after [kBaseUrl]
  /// [encodedJson] = json body
  /// Return type: [Stream]
  ///
  Stream put({@required String url, @required String encodedJson}) {
    _logger.d("PUT request to $_baseUrl/$url");
    return Stream.fromFuture(http.put('$_baseUrl/$url',
            headers: _defaultHeader, body: encodedJson))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        _logger.e(jsonDecode(_.body)["error"]);
        throw Failure(
          statusCode: _.statusCode,
          message: jsonDecode(_.body)["error"],
        );
      } else {
        return Stream.value(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [PATCH] method.
  /// Method Params:
  /// [url] = URL path after [kBaseUrl]
  /// [encodedJson] = json body
  /// Return type: [Stream]
  ///
  Stream patch({@required String url, @required String encodedJson}) {
    _logger.d("PATCH request to $_baseUrl/$url");
    return Stream.fromFuture(http.patch('$_baseUrl/$url',
            headers: _defaultHeader, body: encodedJson))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        _logger.e(jsonDecode(_.body)["error"]);
        throw Failure(
          statusCode: _.statusCode,
          message: jsonDecode(_.body)["error"],
        );
      } else {
        return Stream.value(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  ///
  /// Http [DELETE] method.
  /// Method Params:
  /// [url] = URL path after [kBaseUrl]
  /// Return type: [Stream]
  ///
  Stream delete({@required String url}) {
    _logger.d("DELETE request to $_baseUrl/$url");
    return Stream.fromFuture(
            http.delete('$_baseUrl/$url', headers: _defaultHeader))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        _logger.e(jsonDecode(_.body)["error"]);
        throw Failure(
          statusCode: _.statusCode,
          message: jsonDecode(_.body)["error"],
        );
      } else {
        return Stream.value(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  Future uploadFile(
      {@required String url,
      @required File file,
      @required String fieldName}) async {
    try {
      _logger.d("UPLOAD FILE to $_baseUrl/$url");
      final dio.Dio client = dio.Dio();
      client.options.baseUrl = _baseUrl;
      client.options.headers = _defaultHeader;
      final dio.MultipartFile fileUpload =
          await dio.MultipartFile.fromFile(file.path);
      final dio.FormData formData = dio.FormData();
      formData.files.add(MapEntry(fieldName, fileUpload));
      final dio.Response response = await client.post("/$url", data: formData);
      return response.data;
    } catch (e) {
      _logger.wtf(e.toString());
      throw Failure(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
