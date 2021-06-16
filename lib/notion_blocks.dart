library notion_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'notion/objects/children.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API block children requests.
class NotionBlockClient {
  // The API integration secret token
  String _token;

  // The API version
  String v;

  // The path of the requests group
  String _path = 'blocks';

  NotionBlockClient({required String token, String version: '/v1'})
      : this._token = token,
        this.v = version;

  /// Retrieve the block children from block with [id].
  ///
  /// A [startCursor] can be defined to sepeficied the page where to start.
  /// Also a [pageSize] can be defined to limit the result. The max value is 100.
  Future<NotionResponse> fetch(
    String id, {
    String? startCursor,
    int? pageSize,
  }) async {
    Map<String, dynamic> query = {};
    if (startCursor != null) {
      query['start_cursos'] = startCursor;
    }
    if (pageSize != null && pageSize >= 0 && pageSize <= 100) {
      query['page_size'] = pageSize;
    }

    http.Response response = await http
        .get(Uri.https(host, '$v/$_path/$id/children', query), headers: {
      'Authorization': 'Bearer $_token',
    });

    return NotionResponse.fromResponse(response);
  }

  /// Append a block [children] [to] a specific block.
  Future<NotionResponse> append({
    required String to,
    required Children children,
  }) async {
    http.Response res = await http.patch(
        Uri.https(host, '$v/$_path/$to/children'),
        body: jsonEncode(children.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    return NotionResponse.fromResponse(res);
  }
}
