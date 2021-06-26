/// A wrapper for the public beta Notion API to manage it like a Notion SDK package for dart.
///
/// To see code examples you can go to https://pub.dev/packages/notion_api/example.
///
/// Documentation for Notion API here https://developers.notion.com.
/// API Reference here https://developers.notion.com/reference/intro.
library notion_api;

import 'package:notion_api/statics.dart';

import 'notion_pages.dart';
import 'notion_blocks.dart';
import 'notion_databases.dart';

/// A Notion API client.
class NotionClient {
  /// The Notion API client for pages requests.
  NotionPagesClient pages;

  /// The Notion API client for databases requests.
  NotionBlockClient blocks;

  /// The Notion API client for databases requests.
  NotionDatabasesClient databases;

  /// Main Notion client constructor.
  ///
  /// Require the [token] to authenticate the requests, and the API [version] where to make the calls, which is the latests by default (v1).
  ///
  /// This class is used as the main entry point for all clients. From the instances of this class any other client can be used.
  NotionClient({required String token, String version: latestVersion})
      : this.pages = NotionPagesClient(token: token, version: version),
        this.databases = NotionDatabasesClient(token: token, version: version),
        this.blocks = NotionBlockClient(token: token, version: version);
}
