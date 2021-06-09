library notion_api;

import 'notion_pages.dart';
import 'notion_blocks.dart';
import 'notion_databases.dart';

/// A Notion API client.
class NotionClient {
  // The Notion API client for pages requests
  NotionPagesClient pages;

  // The Notion API client for databases requests
  NotionBlockClient blocks;

  // The Notion API client for databases requests
  NotionDatabasesClient databases;

  NotionClient({required String token, String version: '/v1'})
      : this.pages = NotionPagesClient(token: token, version: version),
        this.databases = NotionDatabasesClient(token: token, version: version),
        this.blocks = NotionBlockClient(token: token, version: version);
}
