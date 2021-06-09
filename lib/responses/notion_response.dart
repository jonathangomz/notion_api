import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/objects/database.dart';
import 'package:notion_api/responses/pagination.dart';
import 'package:notion_api/utils/utils.dart';

class NotionResponse {
  ObjectsTypes object;

  Pagination? pagination;
  Database? database;

  int status;
  String? code;
  String? message;

  bool hasError = false;
  bool isOk = true;

  NotionResponse(
      {this.object: ObjectsTypes.List,
      this.status: 200,
      this.code,
      this.message});

  factory NotionResponse.fromJson(Response res) {
    Map<String, dynamic> json = jsonDecode(res.body);

    NotionResponse _result = NotionResponse(
      status: json['status'] ?? res.statusCode,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );

    _result.object = NotionUtils.stringToObjectType(json['object']);
    if (_result.object == ObjectsTypes.List) {
      _result.pagination = Pagination.fromJson(json);
    } else if (_result.object == ObjectsTypes.Error) {
      _result.hasError = true;
      _result.isOk = false;
    } else if (_result.object == ObjectsTypes.Database) {
      _result.database = Database.fromJson(json);
    }

    return _result;
  }

  bool get isDatabase => this.object == ObjectsTypes.Database;
  bool get isList => this.object == ObjectsTypes.List;
  bool get isError => this.object == ObjectsTypes.Error;
  bool get isObject => this.object == ObjectsTypes.Object;
  bool get isPage => this.object == ObjectsTypes.Page;
}
