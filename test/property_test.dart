import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:test/test.dart';

void main() {
  group('Main property =>', () {
    test('Create an instance of property', () {
      Property prop = Property.empty();
      expect(prop.type, PropertiesTypes.None);
    });

    test('Create a json from property', () {
      Property prop = Property.empty();
      expect(() => prop.toJson(), throwsA(isA<String>()));
    });

    test('Create a json from properties map', () {
      Map<String, Property> json = Property.propertiesFromJson({
        "Tags": {
          "id": ">cp;",
          "type": "multi_select",
          "multi_select": {"options": []}
        },
        "Name": {"id": "title", "type": "title", "title": {}}
      });

      expect(json, isNotEmpty);
      expect(json, contains('Tags'));
      expect(json['Tags']!.isMultiSelect, true);
      expect(json, contains('Name'));
      expect(json['Name']!.isTitle, true);
    });
  });

  group('Title property =>', () {
    test('Create an instance of property', () {
      TitleProp prop = TitleProp(content: [Text('TITLE')]);

      expect(prop.type, PropertiesTypes.Title);
      expect(prop.content, isNotEmpty);
      expect(prop.content.length, 1);
    });
    test('Create an json from property', () {
      Map<String, dynamic> json = TitleProp(content: [Text('TITLE')]).toJson();

      expect(json['type'], 'title');
      expect(json, contains('title'));
      expect((json['title'] as List).length, 1);
    });
  });

  group('RichText property =>', () {
    test('Create an instance of property', () {
      RichTextProp rich = RichTextProp(content: [Text('A'), Text('B')]);

      expect(rich.type, PropertiesTypes.RichText);
      expect(rich.content, isNotEmpty);
      expect(rich.content.length, 2);
    });
    test('Create an json from property', () {
      Map<String, dynamic> json =
          RichTextProp(content: [Text('A'), Text('B')]).toJson();

      expect(json['type'], 'rich_text');
      expect(json, contains('rich_text'));
      expect((json['rich_text'] as List).length, 2);
    });
  });

  group('MultiSelect property =>', () {
    test('Create an instance of property', () {
      MultiSelectProp multi =
          MultiSelectProp(options: [MultiSelectOption(name: 'A')]);

      expect(multi.type, PropertiesTypes.MultiSelect);
      expect(multi.options, isNotEmpty);
      expect(multi.options.length, 1);
    });

    test('Create an json from property', () {
      Map<String, dynamic> json =
          MultiSelectProp(options: [MultiSelectOption(name: 'A')]).toJson();

      expect(json['type'], 'multi_select');
      expect(json, contains('multi_select'));
      expect(json['multi_select'], contains('options'));
      expect(json['multi_select']['options'], isList);
      expect(json['multi_select']['options'], isNotEmpty);
    });
  });

  group('Property response =>', () {
    Map<String, dynamic> json = {
      "id": "title",
      "type": "title",
      "title": [
        {
          "type": "text",
          "text": {"content": "Page from Test", "link": null},
          "annotations": {
            "bold": false,
            "italic": false,
            "strikethrough": false,
            "underline": false,
            "code": false,
            "color": "default"
          },
          "plain_text": "Page from Test",
          "href": null
        }
      ]
    };

    Map<String, dynamic> jsonDetails = {
      "rich_text": [
        {
          "type": "text",
          "text": {"content": "Some more text with "}
        },
        {
          "type": "text",
          "text": {"content": "some"},
          "annotations": {"italic": true}
        },
        {
          "type": "text",
          "text": {"content": " "}
        },
        {
          "type": "text",
          "text": {"content": "formatting"},
          "annotations": {"color": "pink"}
        }
      ]
    };
    Map<String, dynamic> jsonMultiSelectWithoutSubfield = {
      "id": ">cp;",
      "type": "multi_select",
      "multi_select": [
        {"name": "B"},
        {"name": "C"}
      ]
    };
    Map<String, dynamic> jsonMultiSelectWithSubfield = {
      "id": ">cp;",
      "type": "multi_select",
      "multi_select": {
        "options": [
          {"name": "B"},
          {"name": "C"}
        ]
      }
    };
    test('Map name from json response', () {
      TitleProp prop = TitleProp.fromJson(json);

      expect(prop.content, isNotEmpty);
    });

    test('Create json from name json response', () {
      Map<String, dynamic> jsonTest = TitleProp.fromJson(json).toJson();

      expect(jsonTest['type'], 'title');
      expect(jsonTest, contains('title'));
      expect(jsonTest['title'], isList);
    });

    test('Map details from json response', () {
      RichTextProp prop = RichTextProp.fromJson(jsonDetails);

      expect(prop.content, isNotEmpty);
      expect(prop.content.length, 4);
    });

    test('Create json from details json response', () {
      Map<String, dynamic> jsonTest =
          RichTextProp.fromJson(jsonDetails).toJson();

      expect(jsonTest['type'], 'rich_text');
      expect(jsonTest, contains('rich_text'));
      expect(jsonTest['rich_text'], isList);
    });

    test('Map tag from json response without options subfield', () {
      MultiSelectProp multi =
          MultiSelectProp.fromJson(jsonMultiSelectWithoutSubfield);

      expect(multi.options, isNotEmpty);
    });

    test('Map tag from json response with options subfield', () {
      MultiSelectProp multi = MultiSelectProp.fromJson(
          jsonMultiSelectWithSubfield,
          subfield: 'options');

      expect(multi.options, isNotEmpty);
    });
  });
}
