import 'dart:convert';
import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/notion/blocks/bulleted_list_item.dart';
import 'package:notion_api/notion/blocks/heading.dart';
import 'package:notion_api/notion/blocks/numbered_list_item.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/blocks/toggle.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/lists/children.dart';
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

    test('Retrieve all databases with wrong query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetchAll(startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve all databases with query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      const int limit = 2;
      NotionResponse res = await databases.fetchAll(pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });
  });

  group('Notion Block Client =>', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.fetch(testBlockId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve block children with wrong query', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res =
          await blocks.fetch(testBlockId ?? '', startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve block children with query', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      const int limit = 2;
      NotionResponse res =
          await blocks.fetch(testBlockId ?? '', pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });

    test('Append heading & text', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks([
          Heading(text: Text('Test')),
          Paragraph(texts: [
            Text('Lorem ipsum (A)'),
            Text(
              'Lorem ipsum (B)',
              annotations: TextAnnotations(
                bold: true,
                underline: true,
                color: ColorsTypes.Orange,
              ),
            ),
          ], children: [
            Heading(text: Text('Subtitle'), type: 3),
          ]),
        ]),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append todo block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks([
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
          ToDo(text: Text('Todo item with children'), children: [
            BulletedItem(text: Text('A')),
            BulletedItem(text: Text('B')),
          ])
        ]),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append bulleted list item block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks(
          [
            BulletedItem(text: Text('This is a bulleted list item A')),
            BulletedItem(text: Text('This is a bulleted list item B')),
            BulletedItem(
              text: Text('This is a bulleted list item with children'),
              children: [
                Paragraph(texts: [
                  Text('A'),
                  Text('B'),
                  Text('C'),
                ])
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append numbered list item block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks(
          [
            NumberedItem(text: Text('This is a numbered list item A')),
            NumberedItem(text: Text('This is a numbered list item B')),
            NumberedItem(
              text: Text('This is a bulleted list item with children'),
              children: [
                Paragraph(texts: [
                  Text('A'),
                  Text('B'),
                  Text('C'),
                ])
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append toggle block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks(
          [
            Toggle(
              text: Text('This is a toggle block'),
              children: [
                Paragraph(
                  texts: [
                    Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis dolor sed ex egestas, et vehicula tellus faucibus. Sed pellentesque tellus eget imperdiet vulputate.')
                  ],
                ),
                BulletedItem(text: Text('A')),
                BulletedItem(text: Text('B')),
                BulletedItem(text: Text('B')),
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
