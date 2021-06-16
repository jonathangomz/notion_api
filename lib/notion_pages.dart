library notion_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'notion/objects/pages.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API pages requests.
class NotionPagesClient {
  // The API integration secret token
  String _token;

  // The API version
  String v;

  // The path of the requests group
  String _path = 'pages';

  NotionPagesClient({required String token, String version: '/v1'})
      : this._token = token,
        this.v = version;

  /// Retrieve the page with [id]
  Future<NotionResponse> fetch(String id) async {
    http.Response res =
        await http.get(Uri.https(host, '$v/$_path/$id'), headers: {
      'Authorization': 'Bearer $_token',
    });

    return NotionResponse.fromJson(res);
  }

  /// Create a new [page]
  Future<NotionResponse> create(Page page) async {
    http.Response res = await http.post(Uri.https(host, '$v/$_path'),
        body: jsonEncode(page.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    return NotionResponse.fromJson(res);
  }
}
