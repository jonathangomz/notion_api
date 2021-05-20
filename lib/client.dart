library notion_api;

import 'dart:convert';

import 'package:flutter/material.dart' show required;
import 'package:http/http.dart' as http;
import 'package:notion_api/models/pages.dart';

/// A Notion API.
class NotionClient {
  String _token;
  String _url = 'https://api.notion.com/v1';

  NotionClient({@required token}) : this._token = token;

  Future<http.Response> retrievePage(String id) async {
    return await http.get(Uri.parse('$_url/pages/$id'), headers: {
      'Authorization': 'Bearer $_token',
    });
  }

  /// Create a new page
  Future<http.Response> createPage(Page page) async {
    return await http.post(Uri.parse('$_url/pages'),
        body: jsonEncode(page.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
