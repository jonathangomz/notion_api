import 'package:notion_api/notion/blocks/bulleted_list_item.dart';
import 'package:notion_api/notion/blocks/numbered_list_item.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/toggle.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Toggle tests =>', () {
    test('Create an empty instance', () {
      Toggle block = Toggle();

      expect(block, isNotNull);
      expect(block.strType, blockTypeToString(BlockTypes.Toggle));
      expect(block.content, allOf([isList, isEmpty]));
      expect(block.children, allOf([isList, isEmpty]));
      expect(block.isToogle, true);
      expect(block.type, BlockTypes.Toggle);
    });

    test('Create an instance with information', () {
      Toggle block = Toggle(text: Text('A'))
          .addText('B')
          .addChild(
              Paragraph(text: Text('This is a child of the toggle item.')))
          .addChildren([
        BulletedListItem(text: Text('First bulleted item')),
        NumberedListItem(text: Text('First numbered item')),
      ]);

      expect(block.content.length, 2);
      expect(block.content.first.text, 'A');
      expect(block.content.last.text, 'B');
      expect(block.children.length, 3);
    });

    test('Create an instance with mixed information', () {
      Toggle block = Toggle(
        text: Text('first'),
        texts: [
          Text('foo'),
          Text('bar'),
        ],
      )
          .addText('last')
          .addChild(
              Paragraph(text: Text('This is a child of the toggle item.')))
          .addChildren([
        BulletedListItem(text: Text('First bulleted item')),
        NumberedListItem(text: Text('First numbered item')),
      ]);

      expect(block.content.length, 4);
      expect(block.content.first.text, 'first');
      expect(block.content.last.text, 'last');
      expect(block.children.length, 3);
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = Toggle(text: Text('A'), children: [
        BulletedListItem(text: Text('First bulleted item')),
        NumberedListItem(text: Text('First numbered item')),
      ]).toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.Toggle)]));
      expect(json, contains(blockTypeToString(BlockTypes.Toggle)));
      expect(json[blockTypeToString(BlockTypes.Toggle)]['text'],
          allOf([isList, isNotEmpty]));
      expect(json[blockTypeToString(BlockTypes.Toggle)]['children'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Map<String, dynamic> json = Toggle().toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.Toggle)]));
      expect(json, contains(blockTypeToString(BlockTypes.Toggle)));
      expect(json[blockTypeToString(BlockTypes.Toggle)]['text'],
          allOf([isList, isEmpty]));
      expect(json[blockTypeToString(BlockTypes.Toggle)]['children'],
          allOf([isList, isEmpty]));
    });
  });
}
