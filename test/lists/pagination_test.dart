import 'package:notion_api/notion.dart';
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
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
            "created_time": "2021-05-19T20:21:11.420Z",
            "last_edited_time": "2021-06-07T23:02:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "test", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "test",
                "href": null
              }
            ],
            "properties": {
              "Tags": {
                "id": ">cp;",
                "type": "multi_select",
                "multi_select": {"options": []}
              },
              "This is a test": {"id": "title", "type": "title", "title": {}}
            }
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
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
            "created_time": "2021-05-19T20:21:11.420Z",
            "last_edited_time": "2021-06-07T23:02:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "test", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "test",
                "href": null
              }
            ],
            "properties": {
              "Tags": {
                "id": ">cp;",
                "type": "multi_select",
                "multi_select": {"options": []}
              },
              "This is a test": {"id": "title", "type": "title", "title": {}}
            }
          },
          {
            "object": "database",
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf446",
            "created_time": "2021-05-19T20:21:11.420Z",
            "last_edited_time": "2021-06-07T23:02:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": "test", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "test",
                "href": null
              }
            ],
            "properties": {
              "Tags": {
                "id": ">cp;",
                "type": "multi_select",
                "multi_select": {"options": []}
              },
              "This is a test": {"id": "title", "type": "title", "title": {}}
            }
          }
        ],
        "next_cursor": null,
        "has_more": false
      });

      List<Database> exclude = pag
          .filterDatabases(exclude: ['386da3c6-46bb-4581-8807-1fdb2fbbf446']);
      List<Database> include = pag
          .filterDatabases(include: ['386da3c6-46bb-4581-8807-1fdb2fbbf447']);
      List<Database> id =
          pag.filterDatabases(id: '386da3c6-46bb-4581-8807-1fdb2fbbf447');

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

      List<Block> filtered = pag.filterBlocks(onlyLeft: BlockTypes.H1);

      expect(filtered.length, lessThan(pag.list.length));
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
