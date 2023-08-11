import 'dart:convert';

import 'package:http/http.dart' as http;

import 'notion/exports.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API block children requests.
class NotionBlockClient {
  /// The API integration secret token.
  String _token;

  /// The API version.
  String _v;

  /// The API date version.
  ///
  /// It's not the same as the API version.
  String _dateVersion;

  /// The path of the requests group.
  final String path = 'blocks';

  /// Main Notion block client constructor.
  ///
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1). Also can receive the [dateVersion], which is by default "2021-05-13".
  NotionBlockClient({
    required String auth,
    String version = latestVersion,
    String dateVersion = latestDateVersion,
  })  : this._token = auth,
        this._v = version,
        this._dateVersion = dateVersion;

  /// Retrieve the block children from block specified by the [block_id].
  ///
  /// A [startCursor] can be defined to specify the page where to start.
  /// Also a [pageSize] can be defined to limit the result. The max value is 100.
  ///
  /// _See more at https://developers.notion.com/reference/get-block-children_
  Future<NotionResponse> list({
    required String block_id,
    String? startCursor,
    int? pageSize,
  }) async {
    Map<String, dynamic> query = {};
    if (startCursor != null) {
      query['start_cursor'] = startCursor;
    }
    if (pageSize != null && pageSize >= 0 && pageSize <= 100) {
      query['page_size'] = pageSize.toString();
    }

    http.Response response = await http
        .get(Uri.https(host, '/$_v/$path/$block_id/children', query), headers: {
      'Authorization': 'Bearer $_token',
      'Notion-Version': _dateVersion,
    });

    return NotionResponse.fromResponse(response);
  }

  /// Append [children] to a block specified by the [block_id].
  ///
  /// _See more at https://developers.notion.com/reference/patch-block-children_
  Future<NotionResponse> append({
    required String block_id,
    required Children children,
  }) async {
    http.Response res = await http.patch(
        Uri.https(host, '/$_v/$path/$block_id/children'),
        body: jsonEncode(children.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Notion-Version': _dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }
}
