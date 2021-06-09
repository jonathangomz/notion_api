library notion_api;

import 'package:http/http.dart' as http;

import 'responses/notion_response.dart';
import 'statics.dart';

/// A client for Notion API databases requests.
class NotionDatabasesClient {
  // The API integration secret token
  String _token;

  // The API version
  String v;

  // The path of the requests group
  String _path = 'databases';

  NotionDatabasesClient({required String token, String version: '/v1'})
      : this._token = token,
        this.v = version;

  /// Retrieve the database with [id]
  Future<NotionResponse> fetch(String id) async {
    http.Response res =
        await http.get(Uri.https(host, '$v/$_path/$id'), headers: {
      'Authorization': 'Bearer $_token',
    });

    return NotionResponse.fromJson(res);
  }

  /// Retrieve all databases.
  ///
  /// A [startCursor] can be defined to sepeficied the page where to start.
  /// Also a [pageSize] can be defined to limit the result. The max value is 100.
  Future<NotionResponse> fetchAll({String? startCursor, int? pageSize}) async {
    Map<String, dynamic> query = {};
    if (startCursor != null) {
      query['start_cursos'] = startCursor;
    }
    if (pageSize != null && pageSize >= 0 && pageSize <= 100) {
      query['page_size'] = pageSize;
    }

    http.Response res =
        await http.get(Uri.https(host, '$v/$_path', query), headers: {
      'Authorization': 'Bearer $_token',
    });

    return NotionResponse.fromJson(res);
  }
}
