library notion_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/pages.dart';
import 'statics.dart';

/// A client for Notion API pages requests.
class NotionPagesClient {
  // The API integration secret token
  String _token;

  // The path of the requests group
  String _path = 'pages';

  NotionPagesClient({required token}) : this._token = token;

  /// Retrieve the page with [id]
  Future<http.Response> fetch(String id) async {
    return await http.get(Uri.https(host, '$v/$_path/$id'), headers: {
      'Authorization': 'Bearer $_token',
    });
  }

  /// Create a new [page]
  Future<http.Response> create(Page page) async {
    return await http.post(Uri.https(host, '$v/$_path'),
        body: jsonEncode(page.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}
