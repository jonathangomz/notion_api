import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/objects/database.dart';
import 'package:notion_api/notion/general/lists/pagination.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the Response from the Notion API.
class NotionResponse {
  /// The object type of the response.
  ObjectTypes object;

  /// The pagination if the object is a list.
  Pagination? pagination;

  /// The database information if the result is a database.
  Database? database;

  /// The response status.
  int status;

  /// The Notion code for the errors.
  String? code;

  /// The Notion message for the errors.
  String? message;

  /// The marker to know when an error occur.
  bool hasError = false;

  /// The marker to know if the response is ok.
  bool isOk = true;

  get content {
    if (this.isList) {
      return this.pagination;
    } else if (this.isDatabase) {
      return this.database;
    } else {
      return this.pagination;
    }
  }

  /// Returns true if the response is a database.
  bool get isDatabase => this.object == ObjectTypes.Database;

  /// Returns true if the response is a list.
  bool get isList => this.object == ObjectTypes.List;

  /// Returns true if the response is an error.
  bool get isError => this.object == ObjectTypes.Error;

  /// Returns true if the response is an object.
  bool get isObject => this.object == ObjectTypes.Object;

  /// Returns true if the response is a page.
  bool get isPage => this.object == ObjectTypes.Page;

  /// Returns true if the response have no object type.
  bool get isNone => this.object == ObjectTypes.None;

  /// Main Notion response constructor.
  ///
  /// Can receive the [object] type, the [status] code, the error [code] and the error [message].
  ///
  /// By default the [object] type is None and the [status] is zero.
  NotionResponse({
    this.object: ObjectTypes.None,
    this.status: 0,
    this.code,
    this.message,
  });

  /// Map a new Notion response instance from a http [response].
  ///
  /// The class of the [response] parameter is the one in the `http` package.
  factory NotionResponse.fromResponse(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);

    NotionResponse _result = NotionResponse(
      status: json['status'] ?? response.statusCode,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );

    _result.object = stringToObjectType(json['object']);
    if (_result.object == ObjectTypes.List) {
      _result.pagination = Pagination.fromJson(json);
    } else if (_result.object == ObjectTypes.Error) {
      _result.hasError = true;
      _result.isOk = false;
    } else if (_result.object == ObjectTypes.Database) {
      _result.database = Database.fromJson(json);
    }

    return _result;
  }
}
