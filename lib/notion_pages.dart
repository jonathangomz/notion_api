import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notion_api/base_client.dart';
import 'package:notion_api/notion/general/lists/properties.dart';

import 'notion/objects/pages.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API pages requests.
class NotionPagesClient extends BaseClient {
  /// The path of the requests group.
  @override
  final String path = 'pages';

  /// Main Notion page client constructor.
  ///
  /// Require the [token] to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  NotionPagesClient({
    required String token,
    String version: latestVersion,
    String dateVersion: latestDateVersion,
  }) : super(token: token, version: version, dateVersion: dateVersion);

  /// Retrieve the page with [id].
  Future<NotionResponse> fetch(String id) async {
    http.Response res =
        await http.get(Uri.https(host, '/$v/$path/$id'), headers: {
      'Authorization': 'Bearer $token',
      'Notion-Version': dateVersion,
    });

    return NotionResponse.fromResponse(res);
  }

  /// Create a new [page].
  Future<NotionResponse> create(Page page) async {
    http.Response res = await http.post(Uri.https(host, '/$v/$path'),
        body: jsonEncode(page.toJson()),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
          'Notion-Version': dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }

  /// Archive a page with an specified [id].
  Future<NotionResponse> update(
    String id, {
    Properties? properties,
    bool? archived,
  }) async {
    Properties _properties = properties ?? Properties.empty();
    print(jsonEncode({
      'properties': _properties.toJson(),
      if (archived != null) 'archived': archived,
    }));
    http.Response res = await http.patch(Uri.https(host, '/$v/$path/$id'),
        body: jsonEncode({
          'properties': _properties.toJson(),
          'archived': archived,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Notion-Version': dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }
}
