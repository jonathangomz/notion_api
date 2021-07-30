import 'package:notion_api/notion.dart';
import 'package:test/test.dart';

void main() {
  group('Heading tests =>', () {
    test('Create an empty instance', () {
      Heading heading = Heading();

      expect(heading, isNotNull);
      expect(heading.strType, blockTypeToString(BlockTypes.H1));
      expect(heading.content, allOf([isList, isEmpty]));
      expect(heading.isHeading, true);
      expect(heading.type, BlockTypes.H1);
    });

    test('Create an instance with text constructor', () {
      Heading heading = Heading.text(
        'This is a paragraph with a single text',
        annotations: TextAnnotations(bold: true),
        type: 2,
      );

      expect(
          heading.content,
          allOf([
            isList,
            isNotEmpty,
            hasLength(
              1,
            )
          ]));
      expect(heading.content.first.annotations!.bold, isTrue);
      expect(heading.type, BlockTypes.H2);
    });

    test('Create an instance of every heading type', () {
      Heading h1 = Heading(type: 1);
      expect(h1.strType, blockTypeToString(BlockTypes.H1));
      expect(h1.type, BlockTypes.H1);

      Heading h2 = Heading(type: 2);
      expect(h2.strType, blockTypeToString(BlockTypes.H2));
      expect(h2.type, BlockTypes.H2);

      Heading h3 = Heading(type: 3);
      expect(h3.strType, blockTypeToString(BlockTypes.H3));
      expect(h3.type, BlockTypes.H3);

      expect([h1.isHeading, h2.isHeading, h3.isHeading], everyElement(true));
    });

    test('Create an instance with information', () {
      Heading heading = Heading(text: Text('A')).addText('B');

      expect(heading.content.length, 2);
      expect(heading.content.first.text, 'A');
      expect(heading.content.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      Heading heading =
          Heading(text: Text('first'), texts: [Text('foo'), Text('bar')])
              .addText('last');

      expect(heading.content.length, 4);
      expect(heading.content.first.text, 'first');
      expect(heading.content.last.text, 'last');
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = Heading(text: Text('A')).toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.H1)]));
      expect(json, contains(blockTypeToString(BlockTypes.H1)));
      expect(json[blockTypeToString(BlockTypes.H1)]['text'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Map<String, dynamic> json = Heading().toJson();

      expect(json['type'],
          allOf([isNotNull, isNotEmpty, blockTypeToString(BlockTypes.H1)]));
      expect(json, contains(blockTypeToString(BlockTypes.H1)));
      expect(json[blockTypeToString(BlockTypes.H1)]['text'],
          allOf([isList, isEmpty]));
    });
  });
}
