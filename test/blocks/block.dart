import 'package:notion_api/notion_api.dart';
import 'package:test/test.dart';

void main() {
  group('Block tests =>', () {
    test('Create empty instance', () {
      Block block = Block();
      expect(block, isNotNull);
      expect(block.isNone, true);
      expect(block.hasChildren, false);
      expect(block.jsonContent, isMap);
    });

    test('Create an instance with information', () {
      Block block = Block(
        id: '71fa679a-f072-4e70-bf52-6b1e770f5c3c',
        type: BlockTypes.Paragraph,
        hasChildren: false,
        jsonContent: {
          "text": [
            {
              "type": "text",
              "text": {"content": "Subtext A ", "link": null},
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": "Subtext A ",
              "href": null
            },
          ]
        },
        createdTime: '2021-05-20T21:01:00.000Z',
        lastEditedTime: '2021-05-26T19:10:00.000Z',
      );

      expect(block.strType, 'paragraph');
      expect(block.isParagraph, true);
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = Block(
        id: '71fa679a-f072-4e70-bf52-6b1e770f5c3c',
        type: BlockTypes.Paragraph,
        hasChildren: false,
        jsonContent: {
          "text": [
            {
              "type": "text",
              "text": {"content": "Subtext A ", "link": null},
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": "Subtext A ",
              "href": null
            },
          ]
        },
        createdTime: '2021-05-20T21:01:00.000Z',
        lastEditedTime: '2021-05-26T19:10:00.000Z',
      ).toJson();

      expect(json['type'], 'paragraph');
      expect(json[json['type']], allOf([isMap, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Block block = Block();
      expect(() => block.toJson(), throwsA(isA<String>()));
    });

    test('Map list of block from json list', () {
      List<dynamic> json = [
        {
          "object": "block",
          "id": "71fa679a-f072-4e70-bf52-6b1e770f5c3c",
          "created_time": "2021-05-20T21:01:00.000Z",
          "last_edited_time": "2021-05-26T19:10:00.000Z",
          "has_children": false,
          "type": "paragraph",
          "paragraph": {
            "text": [
              {
                "type": "text",
                "text": {"content": "Subtext A ", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "Subtext A ",
                "href": null
              },
              {
                "type": "text",
                "text": {"content": "test", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": true,
                  "color": "default"
                },
                "plain_text": "test",
                "href": null
              }
            ]
          }
        },
        {
          "object": "block",
          "id": "0f8380c3-50e6-490b-b6ef-200bcbcb0d22",
          "created_time": "2021-05-26T19:14:25.899Z",
          "last_edited_time": "2021-05-26T19:14:25.899Z",
          "has_children": false,
          "type": "heading_1",
          "heading_1": {
            "text": [
              {
                "type": "text",
                "text": {
                  "content": "Test",
                  "link": {"url": "null"}
                },
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "Test",
                "href": "null"
              }
            ]
          }
        },
      ];

      List<Block> blocks = Block.fromListJson(json);

      expect(blocks, isNotEmpty);
      expect(blocks.length, 2);
      expect(blocks.first.isParagraph, true);
      expect(blocks.last.isHeading, true);
    });
  });
}
