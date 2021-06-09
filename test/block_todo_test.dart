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
      expect(todo.strType, NotionUtils.blockTypeToString(BlockTypes.ToDo));
      expect(todo.texts, allOf([isList, isEmpty]));
      expect(todo.checked, false);
      expect(todo.isToDo, true);
      expect(todo.type, BlockTypes.ToDo);
    });

    test('Create an instance with information', () {
      ToDo todo = ToDo(text: Text('A'), checked: true).addText(Text('B'));

      expect(todo.checked, true);
      expect(todo.texts.length, 2);
      expect(todo.texts.first.text, 'A');
      expect(todo.texts.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      ToDo todo = ToDo(
        text: Text('first'),
        texts: [
          Text('foo'),
          Text('bar'),
        ],
        checked: true,
      ).addText(Text('last'));

      expect(todo.checked, true);
      expect(todo.texts.length, 4);
      expect(todo.texts.first.text, 'first');
      expect(todo.texts.last.text, 'last');
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = ToDo(text: Text('A')).toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            NotionUtils.blockTypeToString(BlockTypes.ToDo)
          ]));
      expect(json, contains(NotionUtils.blockTypeToString(BlockTypes.ToDo)));
      expect(json[NotionUtils.blockTypeToString(BlockTypes.ToDo)]['text'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Map<String, dynamic> json = ToDo().toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            NotionUtils.blockTypeToString(BlockTypes.ToDo)
          ]));
      expect(json, contains(NotionUtils.blockTypeToString(BlockTypes.ToDo)));
      expect(json[NotionUtils.blockTypeToString(BlockTypes.ToDo)]['text'],
          allOf([isList, isEmpty]));
    });
  });
}
