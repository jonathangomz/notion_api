/// A wrapper for the public beta Notion API to manage it like a Notion SDK package for dart.
///
/// To see code examples you can go to https://pub.dev/packages/notion_api/example.
///
/// Documentation for Notion API here https://developers.notion.com.
/// API Reference here https://developers.notion.com/reference/intro.
library notion_api;

import 'package:notion_api/src/statics.dart';

import 'package:notion_api/src/notion_pages.dart';
import 'package:notion_api/src/notion_blocks.dart';
import 'package:notion_api/src/notion_databases.dart';

// export clients
export 'package:notion_api/src/notion_blocks.dart';
export 'package:notion_api/src/notion_databases.dart';
export 'package:notion_api/src/notion_pages.dart';

// export all other components
export 'package:notion_api/src/notion/exports.dart';
export 'package:notion_api/src/responses/notion_response.dart';
export 'package:notion_api/src/utils/utils.dart';

/// A Notion API client.
class Client {
  /// The Notion API client for pages requests.
  NotionPagesClient pages;

  /// The Notion API client for databases requests.
  NotionBlockClient blocks;

  /// The Notion API client for databases requests.
  NotionDatabasesClient databases;

  /// Main Notion client constructor.
  ///
  /// Require the [auth] to authenticate the requests. Also can receive the API [version] where to make the calls, which is the latests by default (v1); and the [dateVersion] which is by default "2021-05-13" (the latest at 04/07/2021).
  ///
  /// This class is used as the main entry point for all clients. From the instances of this class any other client can be used.
  Client({
    required String auth,
    String version: latestVersion,
    String dateVersion: latestDateVersion,
  })  : this.pages = NotionPagesClient(
            auth: auth, version: version, dateVersion: dateVersion),
        this.databases = NotionDatabasesClient(
            auth: auth, version: version, dateVersion: dateVersion),
        this.blocks = NotionBlockClient(
            auth: auth, version: version, dateVersion: dateVersion);
}
