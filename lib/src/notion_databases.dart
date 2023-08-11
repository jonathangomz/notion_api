import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notion_api/src/notion/new/database/database_property.dart';

import 'notion/exports.dart';
import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API databases requests.
class NotionDatabasesClient {
  /// The API integration secret token.
  String _token;

  /// The API version.
  String _v;

  /// The API date version.
  ///
  /// It's not the same as the API version.
  String _dateVersion;

  /// The path of the requests group.
  final String path = 'databases';

  /// Main Notion database client constructor.
  ///
  /// Require the [auth] token to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1). Also can receive the [dateVersion], which is by default "2021-05-13".
  NotionDatabasesClient({
    required String auth,
    String version = latestVersion,
    String dateVersion = latestDateVersion,
  })  : this._token = auth,
        this._v = version,
        this._dateVersion = dateVersion;

  /// Retrieve the database specified by the [databaseId].
  ///
  /// _See more at https://developers.notion.com/reference/get-database_
  Future<NotionResponse> retrieve({required String databaseId}) async {
    http.Response res = await http.get(
      Uri.https(host, '/$_v/$path/$databaseId'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Notion-Version': _dateVersion,
      },
    );

    return NotionResponse.fromResponse(res);
  }

  /// Create a [database].
  ///
  /// _See more at https://developers.notion.com/reference/create-a-database_
  @deprecated
  Future<NotionResponse> oldCreate(Database database) async {
    http.Response res = await http.post(
      Uri.https(host, '/$_v/$path'),
      body: jsonEncode(database.toRequestJson()),
      headers: {
        'Authorization': 'Bearer $_token',
        'Notion-Version': _dateVersion,
        'Content-Type': 'application/json',
      },
    );

    return NotionResponse.fromResponse(res);
  }

  /// Create a [database].
  ///
  /// _See more at https://developers.notion.com/reference/create-a-database_
  Future<NotionResponse> create({
    required String pageId,
    required DatabaseProperties properties,
    String? title,
  }) async {
    Database database = Database(
      parent: Parent.page(id: pageId),
      properties: properties,
      title: title,
    );

    http.Response res = await http.post(
      Uri.https(host, '/$_v/$path'),
      body: jsonEncode(database.toRequestJson()),
      headers: {
        'Authorization': 'Bearer $_token',
        'Notion-Version': _dateVersion,
        'Content-Type': 'application/json',
      },
    );

    return NotionResponse.fromResponse(res);
  }

  /// Update the database [title] and [properties] with the [databaseId].
  ///
  /// To **add a new property** set the key and the property type. Example:
  /// ```
  /// NotionResponse res = await databases.update(
  /// databaseId: 'some_existing_database_id',
  /// properties: Properties(map: {
  ///   'Tag': DatabaseProperties.Checkbox() // "Tag" will be created as a checkbox property
  /// }));
  /// ```
  ///
  /// To **update an existing property** set the key as the current property name. Example:
  /// ```
  /// NotionResponse res = await databases.update(
  /// databaseId: 'some_existing_database_id',
  /// properties: Properties(map: {
  ///   'Tag': DatabaseProperties.RichText() // If "Tag" was Checkbox will be turn into RichText property
  /// }));
  /// ```
  ///
  /// To **rename an existing property** set the key as the current property name and set the name parameters to the new name. Example:
  /// ```
  /// NotionResponse res = await databases.update(
  /// databaseId: 'some_existing_database_id',
  /// properties: Properties(map: {
  ///   'Tag': DatabaseProperties.RichText(name: 'Details') // "Tag" will be renamed to "Details"
  /// }));
  /// ```
  ///
  /// **Warning:** Cannot change a title property to a different property type.
  ///
  /// _https://developers.notion.com/reference/update-a-database_
  Future<NotionResponse> update({
    required String databaseId,
    List<RichText>? title,
    Properties? properties,
  }) async {
    Map toUpdate = {};

    if (title != null) toUpdate['title'] = title;
    if (properties != null) toUpdate['properties'] = properties;

    http.Response res = await http.patch(
      Uri.https(host, '/$_v/$path/${databaseId}'),
      body: jsonEncode(toUpdate),
      headers: {
        'Authorization': 'Bearer $_token',
        'Notion-Version': _dateVersion,
        'Content-Type': 'application/json',
      },
    );

    return NotionResponse.fromResponse(res);
  }

  /// Retrieve all databases.
  ///
  /// A [startCursor] can be defined to specify the page where to start.
  /// Also a [pageSize] can be defined to limit the result. The max value is 100.
  ///
  /// _See more at https://developers.notion.com/reference/get-databases_
  @deprecated
  Future<NotionResponse> list({String? startCursor, int? pageSize}) async {
    Map<String, dynamic> query = {};
    if (startCursor != null) {
      query['start_cursor'] = startCursor;
    }
    if (pageSize != null && pageSize >= 0 && pageSize <= 100) {
      query['page_size'] = pageSize.toString();
    }

    http.Response res =
        await http.get(Uri.https(host, '/$_v/$path', query), headers: {
      'Authorization': 'Bearer $_token',
      'Notion-Version': _dateVersion,
    });

    return NotionResponse.fromResponse(res);
  }
}
