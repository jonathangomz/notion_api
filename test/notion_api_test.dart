import 'package:flutter_test/flutter_test.dart';
import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/models/pages.dart';
import 'package:notion_api/models/rich_text.dart';
import 'package:notion_api/notion.dart';
import 'package:notion_api/notion_blocks.dart';
import 'package:notion_api/notion_databases.dart';
import 'package:notion_api/notion_pages.dart';

void main() {
  setUpAll(() {
    load();
  });

  tearDownAll(() {
    clean();
  });
  group('Notion Client', () {
    test('Retrieve a page', () async {
      final NotionClient notion = NotionClient(token: env['token']);
      var res = await notion.pages.fetch(env['test_page_id'] as String);
      expect(res.statusCode, 200);
    });
  });

  group('Notion Pages Client', () {
    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: env['token']);

      final Page page = Page(
        databaseId: env['test_database_id'],
        title: Text(content: 'NotionClient: Page test'),
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(token: env['token']);

      final Page page = Page(
        databaseId: env['test_database_id'],
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Retrieve a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: env['token']);
      var res = await pages.fetch(env['test_page_id'] as String);
      expect(res.statusCode, 200);
    });
  });

  group('Notion Databases Client', () {
    test('Retrieve a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: env['token']);

      var res = await databases.fetch(env['test_database_id'] as String);

      expect(res.statusCode, 200);
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: env['token']);

      var res = await databases.fetchAll();

      expect(res.statusCode, 200);
    });
  });

  group('Notion Block Client', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: env['token']);

      var res = await blocks.fetch(env['test_block_id'] as String);

      expect(res.statusCode, 200);
    });
  });
}
