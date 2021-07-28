import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:test/test.dart';

void main() {
  group('Rich text tests', () {
    test('Create instances of Text with default styles', () {
      Text bold =
          Text.bold('This text is bold and green', color: ColorsTypes.Green);
      Text underline = Text.underline('This text is underline');
      Text code = Text.code('This text is code');
      Text italic = Text.italic('This text is italic');

      Text green = Text.color('This text is green', color: ColorsTypes.Green);
      Text blue = Text.color('This text is blue', color: ColorsTypes.Blue);

      expect(bold.annotations!.bold, isTrue);
      expect(bold.annotations!.color, ColorsTypes.Green);
      expect(underline.annotations!.underline, isTrue);
      expect(code.annotations!.code, isTrue);
      expect(italic.annotations!.italic, isTrue);

      expect(green.annotations!.color, ColorsTypes.Green);
      expect(blue.annotations!.color, ColorsTypes.Blue);
    });

    test('Create a list of instances of Text', () {
      List<Text> list = Text.list(texts: [
        Text('A'),
        Text('B'),
        Text('C'),
      ]);

      expect(list.length, 5);
    });

    test('Create a list of instances of Text (one element)', () {
      List<Text> list = Text.list(texts: [Text('A')]);

      expect(list.length, 1);
    });

    test('Create a list of instances of Text (two element)', () {
      List<Text> list = Text.list(texts: [Text('A'), Text('B')]);

      expect(list.length, 3);
      expect(list[list.length - 2].text, ' and ');
    });

    test('Create a list of instances of Text (three element)', () {
      List<Text> list = Text.list(texts: [Text('A'), Text('B'), Text('C')]);

      expect(list.length, 5);
      expect(list[list.length - 2].text, ' and ');
      expect(list[1].text, ', ');
    });

    test('Create a list of instances of Text (custom separators)', () {
      List<Text> list = Text.list(
        texts: [Text('A'), Text('B'), Text('C')],
        separator: '; ',
        lastSeparator: ' y ',
      );

      expect(list.length, 5);
      expect(list[list.length - 2].text, ' y ');
      expect(list[1].text, '; ');
    });
  });
}
