import 'package:notion_api/notion_api.dart';
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

    test('Create an instance with text constructor', () {
      ToDo toDo = ToDo.text(
        'This is a ToDo with a single text',
        annotations: TextAnnotations(bold: true),
        checked: true,
        children: [
          Paragraph.text('This is a children'),
        ],
      );

      expect(
          toDo.content,
          allOf([
            isList,
            isNotEmpty,
            hasLength(
              1,
            )
          ]));
      expect(toDo.content.first.annotations!.bold, isTrue);
      expect(toDo.checked, isTrue);
      expect(
          toDo.children,
          allOf([
            isList,
            isNotEmpty,
            hasLength(1),
          ]));
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
      expect(todo.children.length, 1);
    });

    test('Create an instance with children', () {
      ToDo todo = ToDo(
        text: Text('todo'),
        checked: true,
      ).addChildren([
        Heading(
          text: Text(
            'Subtitle',
            annotations: TextAnnotations(color: ColorsTypes.Green),
          ),
        ),
        Paragraph(
          texts: [
            Text('A'),
            Text('B'),
          ],
        ),
      ]);

      expect(todo.checked, true);
      expect(todo.content.length, 1);
      expect(todo.children.length, 2);
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
