library notion_api;

import 'package:flutter/material.dart' show required;

import 'notion_pages.dart';

/// A Notion API client.
class NotionClient {
  /// Notion API client for pages requests
  NotionPagesClient pages;

  NotionClient({@required token})
      : this.pages = NotionPagesClient(token: token);
}
