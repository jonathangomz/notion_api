import 'package:notion_api/notion_api.dart';
import 'package:test/test.dart';

import '../long_data.dart';

void main() {
  group('Paginations tests =>', () {
    test('Empty databases list', () async {
      Pagination pag = Pagination.fromJson({
        "object": "list",
        "results": [],
        "next_cursor": null,
        "has_more": false
      });

      expect(pag.isEmpty, true);
      expect(pag.list, isEmpty);
    });

    test('Databases list', () async {
      Pagination pag = Pagination.fromJson({
        "object": "list",
        "results": [
          {
            "object": "database",
            "id": "386da3c6-46bb-4581-8877-1fdb2fbbf447",
            "cover": null,
            "icon": null,
            "created_time": "2021-05-19T20:21:00.000Z",
            "created_by": {
              "object": "user",
              "id": "cfea802c-a071-46ff-ac1f-81713e43d15b"
            },
            "last_edited_by": {
              "object": "user",
              "id": "59457011-46b2-4542-8a0b-2ee2602ee02c"
            },
            "last_edited_time": "2022-02-24T06:18:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "New Title", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "New Title",
                "href": null
              }
            ],
            "properties": {
              "Title": {
                "id": "title",
                "name": "Title",
                "type": "title",
                "title": {}
              }
            },
            "parent": {
              "type": "page_id",
              "page_id": "ba3e9659-1de0-4c93-b3ad-78b9b1de5007"
            },
            "url": "https://www.notion.so/386da3c646bb458188071fdb1fbbf447",
            "archived": false
          }
        ],
        "next_cursor": null,
        "has_more": false
      });

      expect(pag.isDatabasesList, true);
      expect(pag.list, hasLength(1));
      expect(pag.list, pag.databases);
    });

    test('Databases list filtered', () async {
      Pagination pag = Pagination.fromJson({
        "object": "list",
        "results": [
          {
            "object": "database",
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf446",
            "cover": null,
            "icon": null,
            "created_time": "2021-05-19T20:21:00.000Z",
            "created_by": {
              "object": "user",
              "id": "cfea802c-a071-46ff-ac1f-81713e43d15b"
            },
            "last_edited_by": {
              "object": "user",
              "id": "59457011-46b2-4542-8a0b-2ee2602ee02c"
            },
            "last_edited_time": "2022-02-24T06:18:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "New Title", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "New Title",
                "href": null
              }
            ],
            "properties": {
              "Title": {
                "id": "title",
                "name": "Title",
                "type": "title",
                "title": {}
              }
            },
            "parent": {
              "type": "page_id",
              "page_id": "ba3e9659-1de0-4c93-b3ad-78b9b1de5007"
            },
            "url": "https://www.notion.so/386da3c646bb458188071fdb1fbbf448",
            "archived": false
          },
          {
            "object": "database",
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf448",
            "cover": null,
            "icon": null,
            "created_time": "2021-05-19T20:21:00.000Z",
            "created_by": {
              "object": "user",
              "id": "cfea802c-a071-46ff-ac1f-81713e43d15b"
            },
            "last_edited_by": {
              "object": "user",
              "id": "59457011-46b2-4542-8a0b-2ee2602ee02c"
            },
            "last_edited_time": "2022-02-24T06:18:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "New Title", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "New Title",
                "href": null
              }
            ],
            "properties": {
              "Title": {
                "id": "title",
                "name": "Title",
                "type": "title",
                "title": {}
              }
            },
            "parent": {
              "type": "page_id",
              "page_id": "ba3e9659-1de0-4c93-b3ad-78b9b1de5007"
            },
            "url": "https://www.notion.so/386da3c646bb458188071fdb1fbbf447",
            "archived": false
          }
        ],
        "next_cursor": null,
        "has_more": false
      });

      List<Database> exclude = pag
          .filterDatabases(exclude: ['386da3c6-46bb-4581-8807-1fdb2fbbf446']);
      List<Database> include = pag
          .filterDatabases(include: ['386da3c6-46bb-4581-8807-1fdb2fbbf448']);
      List<Database> id =
          pag.filterDatabases(id: '386da3c6-46bb-4581-8807-1fdb2fbbf448');

      expect(exclude.length, lessThan(pag.list.length));
      expect(include.length, lessThan(pag.list.length));
      expect(include, exclude);
      expect(id, include);
      expect(id, hasLength(1));
    });

    test('Blocks list', () async {
      Pagination pag = Pagination.fromJson(longBlocksJsonList);

      expect(pag.isEmpty, false);
      expect(pag.isBlocksList, true);
      expect(pag.blocks, isNotEmpty);
      expect(pag.list, isNotEmpty);
      expect(pag.list.first.object, ObjectTypes.Block);
    });

    test('Blocks list with filter', () async {
      Pagination pag = Pagination.fromJson(longBlocksJsonList);

      List<Block> exclude = pag.filterBlocks(exclude: [BlockTypes.H1]);
      List<Block> onlyLeft = pag.filterBlocks(onlyLeft: BlockTypes.H1);
      List<Block> include = pag.filterBlocks(include: [BlockTypes.H1]);
      List<Block> single =
          pag.filterBlocks(id: '71fa679a-f072-4e70-bf52-6b1e770f5c3c');

      expect(exclude.length, lessThan(pag.list.length));
      expect(onlyLeft.length, lessThan(pag.list.length));
      expect(onlyLeft, include);
      expect(single.length, 1);
      expect(single.first.type, BlockTypes.Paragraph);
    });

    test('Wrong json', () {
      Pagination pag = Pagination.fromJson({});

      expect(pag.nextCursor, isNull);
      expect(pag.hasMore, false);
      expect(pag.isEmpty, true);
      expect(pag.list, isEmpty);
    });
  });
}
