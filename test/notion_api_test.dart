import 'package:flutter_test/flutter_test.dart';
import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'dart:io' show Platform;
import 'package:notion_api/models/children.dart';
import 'package:notion_api/models/pages.dart';
import 'package:notion_api/models/rich_text/paragraph.dart';
import 'package:notion_api/models/rich_text/text.dart';
import 'package:notion_api/models/rich_text/colors.dart';
import 'package:notion_api/models/rich_text/heading.dart';
import 'package:notion_api/models/rich_text/todo.dart';
import 'package:notion_api/notion.dart';
import 'package:notion_api/notion_blocks.dart';
import 'package:notion_api/notion_databases.dart';
import 'package:notion_api/notion_pages.dart';

void main() {
  String? token = Platform.environment['TOKEN'];
  String? testDatabaseId = Platform.environment['TEST_DATABASE_ID'];
  String? testPageId = Platform.environment['TEST_PAGE_ID'];
  String? testBlockId = Platform.environment['TEST_BLOCK_ID'];

  String execEnv = env['EXEC_ENV'] ?? Platform.environment['EXEC_ENV'] ?? '';
  if (execEnv != 'github_actions') {
    setUpAll(() {
      load();

      token = env['TOKEN'] ?? token ?? '';
      testDatabaseId = env['TEST_DATABASE_ID'] ?? testDatabaseId ?? '';
      testPageId = env['TEST_PAGE_ID'] ?? testPageId ?? '';
      testBlockId = env['TEST_BLOCK_ID'] ?? testBlockId ?? '';
    });

    tearDownAll(() {
      clean();
    });
  }

  group('Notion Client', () {
    test('Retrieve a page', () async {
      final NotionClient notion = NotionClient(token: token);
      var res = await notion.pages.fetch(testPageId ?? '');
      expect(res.statusCode, 200);
    });
  });

  group('Notion Pages Client', () {
    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);

      final Page page = Page(
        databaseId: testDatabaseId,
        title: 'NotionClient: Page test',
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);

      final Page page = Page(
        databaseId: testDatabaseId,
      );

      var res = await pages.create(page);

      expect(res.statusCode, 200);
    });

    test('Retrieve a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token);
      var res = await pages.fetch(testPageId ?? '');
      expect(res.statusCode, 200);
    });
  });

  group('Notion Databases Client', () {
    test('Retrieve a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token);

      var res = await databases.fetch(testDatabaseId ?? '');

      expect(res.statusCode, 200);
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token);

      var res = await databases.fetchAll();

      expect(res.statusCode, 200);
    });
  });

  group('Notion Block Client', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token);

      var res = await blocks.fetch(testBlockId ?? '');

      expect(res.statusCode, 200);
    });

    test('Append heading & text', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token);

      var res = await blocks.append(
          to: testBlockId as String,
          children: Children(
              heading: Heading('Test'),
              paragraph: Paragraph(content: [
                Text('Lorem ipsum (A)'),
                Text('Lorem ipsum (B)',
                    annotations: TextAnnotations(
                        bold: true,
                        underline: true,
                        color: RichTextColors.orange))
              ])));

      expect(res.statusCode, 200);
    });

    test('Append todo block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token);

      var res = await blocks.append(
          to: testBlockId as String,
          children: Children(toDo: [
            ToDo(text: Text('This is a todo item A')),
            ToDo(
              content: Paragraph(
                content: [
                  Text('This is a todo item'),
                  Text(
                    'B',
                    annotations: TextAnnotations(bold: true),
                  ),
                ],
              ),
            ),
          ]));

      expect(res.statusCode, 200);
    });
  });
}
