import 'dart:convert';

import 'package:http/http.dart' as http;

import 'notion/objects/pages.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API pages requests.
class NotionPagesClient {
  /// The API integration secret token.
  String _token;

  /// The API version.
  String _v;

  /// Notion versioning. For reference, see: [Notion versioning](https://developers.notion.com/reference/versioning)
  String _dateVersion;

  /// The path of the requests group.
  String _path = 'pages';

  /// Main Notion page client constructor.
  ///
  /// Require the [token] to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  NotionPagesClient(
      {required String token,
      String version: latestVersion,
      String dateVersion: latestDateVersion})
      : this._token = token,
        this._v = version,
        this._dateVersion = latestDateVersion;

  /// Retrieve the page with [id].
  Future<NotionResponse> fetch(String id) async {
    http.Response res =
        await http.get(Uri.https(host, '/$_v/$_path/$id'), headers: {
      'Authorization': 'Bearer $_token',
      'Notion-Version': _dateVersion,
    });

    return NotionResponse.fromResponse(res);
  }

  /// Create a new [page].
  Future<NotionResponse> create(Page page) async {
    http.Response res = await http.post(Uri.https(host, '/$_v/$_path'),
        body: jsonEncode(page.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Notion-Version': _dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }
}
