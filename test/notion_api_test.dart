import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/notion/blocks/heading.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/objects/children.dart';
import 'package:notion_api/notion/objects/pages.dart';
import 'package:notion_api/notion.dart';
import 'package:notion_api/notion_blocks.dart';
import 'package:notion_api/notion_databases.dart';
import 'package:notion_api/notion_pages.dart';
import 'package:notion_api/responses/notion_response.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:test/test.dart';

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
      final NotionClient notion = NotionClient(token: token ?? '');
      NotionResponse res = await notion.pages.fetch(testPageId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });

  group('Notion Pages Client =>', () {
    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
        title: Text('NotionClient (v1): Page test'),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Invalid property', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
      ).addProperty(
        name: 'TEST',
        property: TitleProp(content: [Text('ABC')]),
      );

      var res = await pages.create(page);

      expect(res.status, 400);
      expect(res.isError, true);
      expect(res.code, 'validation_error');
    });
  });

  group('Notion Databases Client', () {
    test('Retrieve a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetch(testDatabaseId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetchAll();

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });

  group('Notion Block Client', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.fetch(testBlockId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Wrong uuid for block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.fetch(
          testBlockId != null ? testBlockId!.replaceFirst('d', 'b') : '');

      expect(res.status, 404);
      expect(res.isOk, false);
      expect(res.hasError, true);
      expect(res.object, 'error');
      expect(res.code, 'object_not_found');
    });

    test('Wrong auth for block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: '');

      NotionResponse res = await blocks.fetch(testBlockId ?? '');

      expect(res.status, 401);
      expect(res.isOk, false);
      expect(res.hasError, true);
      expect(res.object, 'error');
      expect(res.code, 'unauthorized');
    });

    test('Append heading & text', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children(
          heading: Heading(text: Text('Test')),
          paragraph: Paragraph(
            texts: [
              Text('Lorem ipsum (A)'),
              Text(
                'Lorem ipsum (B)',
                annotations: TextAnnotations(
                  bold: true,
                  underline: true,
                  color: ColorsTypes.Orange,
                ),
              ),
            ],
          ),
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append todo block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children(
          toDo: [
            ToDo(text: Text('This is a todo item A')),
            ToDo(
              texts: [
                Text('This is a todo item'),
                Text(
                  'B',
                  annotations: TextAnnotations(bold: true),
                ),
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });
}
