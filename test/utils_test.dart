import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Utils tests (General)', () {
    test('Check if a dynamic field is a list (List)', () {
      dynamic field = [1, 2, 3];
      bool isList = NotionUtils.fieldIsList(field);
      expect(isList, true);
    });

    test('Check if a dynamic field is a list (Map)', () {
      dynamic field = {1: 'A', 2: 'B'};
      bool isList = NotionUtils.fieldIsList(field);
      expect(isList, false);
    });

    test('Check if a dynamic field is a list (String)', () {
      dynamic field = 'ABC';
      bool isList = NotionUtils.fieldIsList(field);
      expect(isList, false);
    });

    test('Get the property type (with type)', () {
      Map<String, dynamic> titleField = {
        'type': 'title',
        'title': {'text': []}
      };
      Map<String, dynamic> richTextField = {
        'type': 'rich_text',
        'rich_text': {'text': []}
      };
      Map<String, dynamic> multiSelectField = {
        'type': 'multi_select',
        'multi_select': []
      };

      PropertiesTypes titleType = NotionUtils.extractPropertyType(titleField);
      PropertiesTypes richTextType =
          NotionUtils.extractPropertyType(richTextField);
      PropertiesTypes multiSelectType =
          NotionUtils.extractPropertyType(multiSelectField);

      expect(titleType, PropertiesTypes.Title);
      expect(richTextType, PropertiesTypes.RichText);
      expect(multiSelectType, PropertiesTypes.MultiSelect);
    });

    test('Get the property type (without type)', () {
      Map<String, dynamic> titleField = {
        'title': {'text': []}
      };
      Map<String, dynamic> richTextField = {
        'rich_text': {'text': []}
      };
      Map<String, dynamic> multiSelectField = {'multi_select': []};

      PropertiesTypes titleType = NotionUtils.extractPropertyType(titleField);
      PropertiesTypes richTextType =
          NotionUtils.extractPropertyType(richTextField);
      PropertiesTypes multiSelectType =
          NotionUtils.extractPropertyType(multiSelectField);

      expect(titleType, PropertiesTypes.Title);
      expect(richTextType, PropertiesTypes.RichText);
      expect(multiSelectType, PropertiesTypes.MultiSelect);
    });

    test('Get the property type (no type)', () {
      Map<String, dynamic> field = {};
      PropertiesTypes type = NotionUtils.extractPropertyType(field);
      expect(type, PropertiesTypes.None);
    });
  });

  group('Utils tests (ObjectTypes) =>', () {
    test('Return an ObjectTypes type', () {
      ObjectTypes type1 = NotionUtils.stringToObjectType('invali_string');
      ObjectTypes type2 = NotionUtils.stringToObjectType('database');
      ObjectTypes type3 = NotionUtils.stringToObjectType('block');
      ObjectTypes type4 = NotionUtils.stringToObjectType('error');
      ObjectTypes type5 = NotionUtils.stringToObjectType('page');

      expect([type1, type2, type3, type4, type5],
          everyElement(isA<ObjectTypes>()));
      expect(type1, ObjectTypes.None);
      expect(type2, ObjectTypes.Database);
      expect(type3, ObjectTypes.Block);
      expect(type4, ObjectTypes.Error);
      expect(type5, ObjectTypes.Page);
    });

    test('Invalid string return None type', () {
      ObjectTypes type1 = NotionUtils.stringToObjectType('invali_string');
      ObjectTypes type2 = NotionUtils.stringToObjectType('asdlfknasdkjl');
      ObjectTypes type3 = NotionUtils.stringToObjectType('');

      expect([type1, type2, type3], everyElement(ObjectTypes.None));
    });
  });

  group('Utils tests (BlockTypes) =>', () {
    test('Return an ObjectTypes type', () {
      BlockTypes type1 = NotionUtils.stringToBlockType('invalid_string');
      BlockTypes type2 = NotionUtils.stringToBlockType('heading_2');
      BlockTypes type3 = NotionUtils.stringToBlockType('paragraph');
      BlockTypes type4 = NotionUtils.stringToBlockType('to_do');
      BlockTypes type5 = NotionUtils.stringToBlockType('toogle');

      expect(
          [type1, type2, type3, type4, type5], everyElement(isA<BlockTypes>()));
      expect(type1, BlockTypes.None);
      expect(type2, BlockTypes.H2);
      expect(type3, BlockTypes.Paragraph);
      expect(type4, BlockTypes.ToDo);
      expect(type5, BlockTypes.Toogle);
    });

    test('Invalid string return None type', () {
      BlockTypes type1 = NotionUtils.stringToBlockType('invalid_string');
      BlockTypes type2 = NotionUtils.stringToBlockType('asdlfknasdkjl');
      BlockTypes type3 = NotionUtils.stringToBlockType('');

      expect([type1, type2, type3], everyElement(BlockTypes.None));
    });
  });

  group('Utils tests (PropertiesTypes) =>', () {
    test('Return an ObjectTypes type', () {
      PropertiesTypes type1 =
          NotionUtils.stringToPropertyType('invalid_string');
      PropertiesTypes type2 = NotionUtils.stringToPropertyType('title');
      PropertiesTypes type3 = NotionUtils.stringToPropertyType('rich_text');
      PropertiesTypes type4 = NotionUtils.stringToPropertyType('number');
      PropertiesTypes type5 = NotionUtils.stringToPropertyType('select');

      expect([type1, type2, type3, type4, type5],
          everyElement(isA<PropertiesTypes>()));
      expect(type1, PropertiesTypes.None);
      expect(type2, PropertiesTypes.Title);
      expect(type3, PropertiesTypes.RichText);
      expect(type4, PropertiesTypes.Number);
      expect(type5, PropertiesTypes.Select);
    });

    test('Invalid string return None type', () {
      PropertiesTypes type1 =
          NotionUtils.stringToPropertyType('invalid_string');
      PropertiesTypes type2 = NotionUtils.stringToPropertyType('asdlfknasdkjl');
      PropertiesTypes type3 = NotionUtils.stringToPropertyType('');

      expect([type1, type2, type3], everyElement(PropertiesTypes.None));
    });
  });
}
