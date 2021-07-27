import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notion_api/base_client.dart';

import 'notion/general/lists/children.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API block children requests.
class NotionBlockClient extends BaseClient {
  /// The path of the requests group.
  @override
  final String path = 'blocks';

  /// Main Notion block client constructor.
  ///
  /// Require the [token] to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  NotionBlockClient({
    required String token,
    String version: latestVersion,
    String dateVersion: latestDateVersion,
  }) : super(token: token, version: version, dateVersion: dateVersion);

  /// Retrieve the block children from block with [id].
  ///
  /// A [startCursor] can be defined to specify the page where to start.
  /// Also a [pageSize] can be defined to limit the result. The max value is 100.
  ///
  /// _See more at https://developers.notion.com/reference/get-block-children_
  Future<NotionResponse> fetch(
    String id, {
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
        .get(Uri.https(host, '/$v/$path/$id/children', query), headers: {
      'Authorization': 'Bearer $token',
      'Notion-Version': dateVersion,
    });

    return NotionResponse.fromResponse(response);
  }

  /// Append a block [children] [to] a specific block.
  ///
  /// _See more at https://developers.notion.com/reference/patch-block-children_
  Future<NotionResponse> append({
    required String to,
    required Children children,
  }) async {
    http.Response res = await http.patch(
        Uri.https(host, '/$v/$path/$to/children'),
        body: jsonEncode(children.toJson()),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Notion-Version': dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }
}
