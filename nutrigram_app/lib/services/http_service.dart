import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class HttpService {
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
    return Stream.fromFuture(http.get(
      '$_baseUrl/$url',
      headers: _defaultHeader,
    )).flatMap((_) {
      if (_.statusCode >= 400) {
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
    return Stream.fromFuture(http.post(
      '$_baseUrl/$url',
      headers: _defaultHeader,
      body: encodedJson,
    )).flatMap((data) {
      if (data.statusCode >= 400) {
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
    return Stream.fromFuture(http.put('$_baseUrl/$url',
            headers: _defaultHeader, body: encodedJson))
        .flatMap((_) {
      if (_.statusCode >= 400) {
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
    return Stream.fromFuture(http.patch('$_baseUrl/$url',
            headers: _defaultHeader, body: encodedJson))
        .flatMap((_) {
      if (_.statusCode >= 400) {
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
    return Stream.fromFuture(
            http.delete('$_baseUrl/$url', headers: _defaultHeader))
        .flatMap((_) {
      if (_.statusCode >= 400) {
        throw Failure(
          statusCode: _.statusCode,
          message: jsonDecode(_.body)["error"],
        );
      } else {
        return Stream.value(_);
      }
    }).map((_) => jsonDecode(_.body));
  }

  Future<http.StreamedResponse> uploadFile(
      {@required String url,
      @required File file,
      @required String fieldName}) async {
    final postUri = Uri.parse('$_baseUrl/$url');
    final http.MultipartRequest request =
        http.MultipartRequest('POST', postUri);

    request.headers.addEntries([
      MapEntry(
          HttpHeaders.authorizationHeader, "Bearer ${_userDataService.token}")
    ]);

    final http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath(fieldName, file.path);

    request.files.add(multipartFile);
    // return Stream.fromFuture(request.send());
    return request.send();
  }
}
