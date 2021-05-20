library notion_api;

import 'package:notion_api/notion_blocks.dart';
import 'package:notion_api/notion_databases.dart';

import 'notion_pages.dart';

/// A Notion API client.
class NotionClient {
  // The Notion API client for pages requests
  NotionPagesClient pages;

  // The Notion API client for databases requests
  NotionBlockClient blocks;

  // The Notion API client for databases requests
  NotionDatabasesClient databases;

  NotionClient({required token})
      : this.pages = NotionPagesClient(token: token),
        this.databases = NotionDatabasesClient(token: token),
        this.blocks = NotionBlockClient(token: token);
}
