import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('ToDo tests =>', () {
    test('Create an empty instance', () {
      ToDo todo = ToDo();

      expect(todo, isNotNull);
      expect(todo.strType, blockTypeToString(BlockTypes.ToDo));
      expect(todo.content, allOf([isList, isEmpty]));
      expect(todo.checked, false);
      expect(todo.isToDo, true);
      expect(todo.type, BlockTypes.ToDo);
    });

    test('Create an instance with information', () {
      ToDo todo = ToDo(text: Text('A'), checked: true).addText('B');

      expect(todo.checked, true);
      expect(todo.content.length, 2);
      expect(todo.content.first.text, 'A');
      expect(todo.content.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      ToDo todo = ToDo(
        text: Text('first'),
        texts: [
          Text('foo'),
          Text('bar'),
        ],
        checked: true,
      ).addText('last').addChild(Paragraph(texts: [
            Text('A'),
            Text('B'),
          ]));

      expect(todo.checked, true);
      expect(todo.content.length, 4);
      expect(todo.content.first.text, 'first');
      expect(todo.content.last.text, 'last');
      expect(todo.children.length, 4);
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = ToDo(text: Text('A'))
          .addChild(Paragraph(texts: [
            Text('A'),
            Text('B'),
          ]))
          .toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.ToDo)]));
      expect(json, contains(blockTypeToString(BlockTypes.ToDo)));
      expect(json[blockTypeToString(BlockTypes.ToDo)]['text'],
          allOf([isList, isNotEmpty]));
      expect(json[blockTypeToString(BlockTypes.ToDo)]['children'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Map<String, dynamic> json = ToDo().toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.ToDo)]));
      expect(json, contains(blockTypeToString(BlockTypes.ToDo)));
      expect(json[blockTypeToString(BlockTypes.ToDo)]['text'],
          allOf([isList, isEmpty]));
      expect(json[blockTypeToString(BlockTypes.ToDo)]['children'],
          allOf([isList, isEmpty]));
    });
  });
}
