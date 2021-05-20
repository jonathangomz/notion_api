import 'package:flutter_test/flutter_test.dart';
import 'package:notion_api/models/pages.dart';
import 'package:notion_api/models/rich_text.dart';
import 'package:notion_api/notion.dart';
import 'package:notion_api/notion_databases.dart';
import 'package:notion_api/notion_pages.dart';

import '../env.dart';

void main() {
  group('Notion Client', () {
    test('Retrieve a page', () async {
      final NotionClient notion = NotionClient(token: token);
      var res = await notion.pages.fetch(test_page_id);
      expect(res.statusCode, 200);
    });
  });

  group('Notion Pages Client', () {
    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);

      final Page page = Page(
        databaseId: test_database_id,
        title: Text(content: 'NotionClient: Page test'),
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);

      final Page page = Page(
        databaseId: test_database_id,
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Retrieve a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);
      var res = await pages.fetch(test_page_id);
      expect(res.statusCode, 200);
    });
  });

  group('Notion Databases Client', () {
    test('Retrieve a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token);

      var res = await databases.fetch(test_database_id);

      print(res.body);

      expect(res.statusCode, 200);
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token);

      var res = await databases.fetchAll();

      print(res.body);

      expect(res.statusCode, 200);
    });
  });
}
