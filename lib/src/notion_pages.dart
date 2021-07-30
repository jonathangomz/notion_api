import 'dart:convert';

import 'package:http/http.dart' as http;

import 'notion/exports.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API pages requests.
class NotionPagesClient {
  /// The API integration secret token.
  String _token;

  /// The API version.
  String _v;

  /// The API date version.
  ///
  /// It's not the same as the API version.
  String _dateVersion;

  /// The path of the requests group.
  final String path = 'pages';

  /// Main Notion page client constructor.
  ///
  /// Require the [token] to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  NotionPagesClient({
    required String token,
    String version: latestVersion,
    String dateVersion: latestDateVersion,
  })  : this._token = token,
        this._v = version,
        this._dateVersion = dateVersion;

  /// Retrieve the page with [id].
  ///
  /// _See more at https://developers.notion.com/reference/get-page_
  Future<NotionResponse> fetch(String id) async {
    http.Response res =
        await http.get(Uri.https(host, '/$_v/$path/$id'), headers: {
      'Authorization': 'Bearer $_token',
      'Notion-Version': _dateVersion,
    });

    return NotionResponse.fromResponse(res);
  }

  /// Create a new [page].
  ///
  /// _See more at https://developers.notion.com/reference/post-page_
  Future<NotionResponse> create(Page page) async {
    http.Response res = await http.post(
      Uri.https(host, '/$_v/$path'),
      body: jsonEncode(page.toJson()),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json; charset=UTF-8',
        'Notion-Version': _dateVersion,
      },
    );

    return NotionResponse.fromResponse(res);
  }

  /// Update the [properties] of the page with an specified [id]. Can also mark the page as [archived].
  ///
  /// The page should contain the property to update.
  ///
  /// Archive a page is the equivalent to delete it according to API reference.
  ///
  /// _See more at https://developers.notion.com/reference/patch-page_
  Future<NotionResponse> update(
    String id, {
    Properties? properties,
    bool? archived,
  }) async {
    Properties _properties = properties ?? Properties.empty();
    http.Response res = await http.patch(Uri.https(host, '/$_v/$path/$id'),
        body: jsonEncode({
          'properties': _properties.toJson(),
          if (archived != null) 'archived': archived,
        }),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Notion-Version': _dateVersion,
        });

    return NotionResponse.fromResponse(res);
  }
}
