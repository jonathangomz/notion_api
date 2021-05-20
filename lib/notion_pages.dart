library notion_api;

import 'dart:convert';

import 'package:flutter/material.dart' show required;
import 'package:http/http.dart' as http;

import 'models/pages.dart';

/// A client for Notion API pages requests.
class NotionPagesClient {
  String _token;
  String _url = 'https://api.notion.com/v1/pages';

  NotionPagesClient({@required token}) : this._token = token;

  /// Retrieve a page
  Future<http.Response> fetch(String id) async {
    return await http.get(Uri.parse('$_url/$id'), headers: {
      'Authorization': 'Bearer $_token',
    });
  }

  /// Create a new page
  Future<http.Response> create(Page page) async {
    return await http
        .post(Uri.parse('$_url'), body: jsonEncode(page.toJson()), headers: {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}
