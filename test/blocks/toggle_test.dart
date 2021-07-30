import 'package:notion_api/notion.dart';
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

    test('Create an instance with text constructor', () {
      Toggle block = Toggle.text(
        'This is a paragraph with a single text',
        annotations: TextAnnotations(bold: true),
        children: [
          Paragraph.text('This is a children'),
        ],
      );

      expect(
          block.content,
          allOf([
            isList,
            isNotEmpty,
            hasLength(
              1,
            )
          ]));
      expect(block.content.first.annotations!.bold, isTrue);
      expect(
          block.children,
          allOf([
            isList,
            isNotEmpty,
            hasLength(1),
          ]));
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
