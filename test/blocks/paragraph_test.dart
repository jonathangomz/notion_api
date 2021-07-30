import 'package:notion_api/notion.dart';
import 'package:test/test.dart';

void main() {
  group('Paragraph tests =>', () {
    test('Create an instance', () {
      Paragraph paragraph = Paragraph();

      expect(paragraph, isNotNull);
      expect(paragraph.strType, blockTypeToString(BlockTypes.Paragraph));
      expect(paragraph.content, allOf([isList, isEmpty]));
      expect(paragraph.isParagraph, true);
      expect(paragraph.type, BlockTypes.Paragraph);
    });

    test('Create an instance with text constructor', () {
      Paragraph paragraph = Paragraph.text(
        'This is a paragraph with a single text',
        annotations: TextAnnotations(bold: true),
        children: [
          Paragraph.text('This is a children'),
        ],
      );

      expect(
          paragraph.content,
          allOf([
            isList,
            isNotEmpty,
            hasLength(
              1,
            )
          ]));
      expect(paragraph.content.first.annotations!.bold, isTrue);
      expect(
          paragraph.children,
          allOf([
            isList,
            isNotEmpty,
            hasLength(1),
          ]));
    });

    test('Create an instance with information', () {
      Paragraph paragraph = Paragraph().addText('A').addText('B');

      expect(paragraph.content.length, 2);
      expect(paragraph.content.first.text, 'A');
      expect(paragraph.content.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      Paragraph paragraph =
          Paragraph(text: Text('first'), texts: [Text('foo'), Text('bar')])
              .addText('last')
              .addChild(Paragraph(texts: [
                Text('A'),
                Text('B'),
              ]));

      expect(paragraph.content.length, 4);
      expect(paragraph.content.first.text, 'first');
      expect(paragraph.content.last.text, 'last');
      expect(paragraph.children.length, 1);
    });

    test('Create an instance with children', () {
      Paragraph paragraph = Paragraph(text: Text('paragraph')).addChildren([
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

      expect(paragraph.content.length, 1);
      expect(paragraph.children.length, 2);
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = Paragraph()
          .addText('A')
          .addText('B')
          .addChild(Paragraph(texts: [
            Text('A'),
            Text('B'),
          ]))
          .toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            blockTypeToString(BlockTypes.Paragraph)
          ]));
      expect(json, contains(blockTypeToString(BlockTypes.Paragraph)));
      expect(json[blockTypeToString(BlockTypes.Paragraph)]['text'],
          allOf([isList, isNotEmpty]));
      expect(json[blockTypeToString(BlockTypes.Paragraph)]['children'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from emppty instance', () {
      Map<String, dynamic> json = Paragraph().toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            blockTypeToString(BlockTypes.Paragraph)
          ]));
      expect(json, contains(blockTypeToString(BlockTypes.Paragraph)));
      expect(json[blockTypeToString(BlockTypes.Paragraph)]['text'],
          allOf([isList, isEmpty]));
      expect(json[blockTypeToString(BlockTypes.Paragraph)]['children'],
          allOf([isList, isEmpty]));
    });
  });
}
