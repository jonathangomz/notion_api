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

  NotionClient({required token})
      : this.pages = NotionPagesClient(token: token),
        this.databases = NotionDatabasesClient(token: token),
        this.blocks = NotionBlockClient(token: token);
}
