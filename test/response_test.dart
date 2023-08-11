import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/notion_api.dart';
import 'package:test/test.dart';

void main() {
  String? token = Platform.environment['TOKEN'];
  String? testDatabaseId = Platform.environment['TEST_DATABASE_ID'];
  String? testPageId = Platform.environment['TEST_PAGE_ID'];
  String? testBlockId = Platform.environment['TEST_BLOCK_ID'];
  String? testBlockHeadingId = Platform.environment['TEST_BLOCK_HEADING_ID'];

  String execEnv = env['EXEC_ENV'] ?? Platform.environment['EXEC_ENV'] ?? '';
  if (execEnv != 'github_actions') {
    setUpAll(() {
      load();

      token = env['TOKEN'] ?? token ?? '';
      testDatabaseId = env['TEST_DATABASE_ID'] ?? testDatabaseId ?? '';
      testPageId = env['TEST_PAGE_ID'] ?? testPageId ?? '';
      testBlockId = env['TEST_BLOCK_ID'] ?? testBlockId ?? '';
      testBlockHeadingId =
          env['TEST_BLOCK_HEADING_ID'] ?? testBlockHeadingId ?? '';
    });

    tearDownAll(() {
      clean();
    });
  }

  group('Response errors tests =>', () {
    test('Create an empty instance', () {
      final NotionResponse response = NotionResponse();

      expect(response, isNotNull);
      expect(response.status, 0);
      expect(response.code, isNull);
      expect(response.message, isNull);
      expect(response.isNone, true);
      expect(response.content, isNull);
    });

    test('Create an instance from auth error response', () async {
      final NotionResponse res = await Client(auth: '').databases.list();

      expect(res.hasError, true);
      expect(res.isError, true);
      expect(res.status, 401);
      expect(res.code, 'unauthorized');
    });

    test('Invalid field (children) for block', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      // Heading block do not support children
      var res = await blocks.append(
        block_id: testBlockHeadingId ?? '',
        children: Children.withBlocks(
          [
            Paragraph(
              texts: [
                Text('A'),
                Text('B'),
              ],
            )
          ],
        ),
      );

      expect(res.status, 400);
      expect(res.isError, true);
      expect(res.code, 'validation_error');
    });

    test('Invalid property', () async {
      final NotionPagesClient pages = NotionPagesClient(auth: token ?? '');

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

    test('Wrong uuid for block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.list(
          block_id:
              testBlockId != null ? testBlockId!.replaceFirst('d', 'b') : '');

      expect(res.status, 404);
      expect(res.isOk, false);
      expect(res.hasError, true);
      expect(res.isError, true);
      expect(res.code, 'object_not_found');
    });
  });

  group('Response lists tests =>', () {
    test('Fetch a list', () async {
      NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      NotionResponse res = await databases.list();

      expect(res.status, 200);
      expect(res.hasError, false);
      expect(res.object, ObjectTypes.List);
      expect(res.content.hasMore, false);
      expect(res.content.isEmpty, true);
      expect(res.content.nextCursor, isNull);
    });

    test('Fetch databases list', () async {
      NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      NotionResponse res = await databases.list();

      expect(res.content.isEmpty, true);
      expect(res.content.list, isEmpty);
    });

    test('Fetch blocks children', () async {
      NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.list(block_id: testBlockId ?? '');

      expect(res.content.isEmpty, false);
      expect(res.content.isBlocksList, true);
      expect(res.content.blocks, isNotEmpty);
      expect(res.content.list, isNotEmpty);
      expect(res.content.list.first.object, ObjectTypes.Block);
    });
  });

  group('Database response test =>', () {
    test('Instance from response', () async {
      NotionDatabasesClient db = NotionDatabasesClient(auth: token ?? '');

      NotionResponse response =
          await db.retrieve(databaseId: testDatabaseId ?? '');

      expect(response.isDatabase, true);
      expect(response.content.title, 'New Title');
      expect(response.content.properties.entries,
          allOf([isMap, isNotEmpty, hasLength(3)]));
    });
  });
}
