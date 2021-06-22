import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Paragraph tests =>', () {
    test('Create an instance', () {
      Paragraph paragraph = Paragraph();

      expect(paragraph, isNotNull);
      expect(paragraph.strType, blockTypeToString(BlockTypes.Paragraph));
      expect(paragraph.texts, allOf([isList, isEmpty]));
      expect(paragraph.isParagraph, true);
      expect(paragraph.type, BlockTypes.Paragraph);
    });

    test('Create an instance with information', () {
      Paragraph paragraph = Paragraph().add(Text('A')).add(Text('B'));

      expect(paragraph.texts.length, 2);
      expect(paragraph.texts.first.text, 'A');
      expect(paragraph.texts.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      Paragraph paragraph =
          Paragraph(text: Text('first'), texts: [Text('foo'), Text('bar')])
              .add(Text('last'));

      expect(paragraph.texts.length, 4);
      expect(paragraph.texts.first.text, 'first');
      expect(paragraph.texts.last.text, 'last');
    });

    test('Create json from instance', () {
      Map<String, dynamic> json =
          Paragraph().add(Text('A')).add(Text('B')).toJson();

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
    });

    test('Create json with separator', () {
      String char = 'A';
      String separator = '-';

      Map<String, dynamic> json =
          Paragraph(textSeparator: separator).add(Text(char)).toJson();

      List jsonTexts = json[blockTypeToString(BlockTypes.Paragraph)]['text'];

      List<Text> texts = Text.fromListJson(jsonTexts);

      expect(texts, isList);
      expect(texts.first.text, char + separator);
    });
  });
}
