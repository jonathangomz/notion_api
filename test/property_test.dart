import 'package:notion_api/notion.dart';
import 'package:test/test.dart';

void main() {
  group('Main property =>', () {
    test('Create an instance of property', () {
      Property prop = Property.empty();
      expect(prop.type, PropertiesTypes.None);
      expect(prop.value, false);
    });

    test('Create a json from empty property', () {
      Property prop = Property.empty();
      expect(() => prop.toJson(), throwsA(isA<String>()));
    });

    test('Create a property from json', () {
      Property prop = Property.propertyFromJson(
          {"id": "title", "type": "title", "title": {}});

      expect(prop.isTitle, true);
      expect(prop.type, PropertiesTypes.Title);
      expect(prop.strType, propertyTypeToString(PropertiesTypes.Title));
    });

    test('Create a properties map from json', () {
      Map<String, Property> json = Property.propertiesFromJson({
        "Tags": {
          "id": ">cp;",
          "type": "multi_select",
          "multi_select": {"options": []}
        },
        "Name": {
          "id": "title",
          "type": "title",
          "title": {},
        },
        "Details": {
          'id': 'D[X|',
          'type': 'rich_text',
          "rich_text": [
            {
              "type": "text",
              "text": {"content": "foo bar"}
            }
          ]
        },
        "Quantity": {
          "number": 1234,
        }
      });

      expect(json, isNotEmpty);
      expect(json, contains('Tags'));
      expect(json['Tags']!.isMultiSelect, true);
      expect(json, contains('Name'));
      expect(json['Name']!.isTitle, true);
      expect(json, contains('Details'));
      expect(json['Details']!.isRichText, true);
      expect(json, contains('Quantity'));
      expect(json['Quantity']!.isNone, true);
    });

    test('Create json from Property inherited class', () {
      Property prop = TitleProp(content: [Text('Title')]);
      Map<String, dynamic> json = prop.toJson();

      String strType = propertyTypeToString(PropertiesTypes.Title);
      expect(json['type'], strType);
      expect(json, contains(strType));
      expect((json[strType] as List).length, 1);
    });

    test('Check if property is empty', () {
      bool isEmptyTrue = Property.isEmpty(
          {'id': 'title', 'type': 'title', 'title': []}, PropertiesTypes.Title);
      bool isEmptyFalse = Property.isEmpty({
        'id': 'title',
        'type': 'title',
        'title': [
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
      }, PropertiesTypes.Title);
      expect(isEmptyTrue, true);
      expect(isEmptyFalse, false);
    });
  });

  group('Title property =>', () {
    test('Create an instance of property', () {
      TitleProp prop = TitleProp(content: [Text('TITLE')]);

      expect(prop.type, PropertiesTypes.Title);
      expect(prop.content, isNotEmpty);
      expect(prop.content.length, 1);
    });

    test('Create a json from property', () {
      Map<String, dynamic> json = TitleProp(content: [Text('TITLE')]).toJson();

      String strType = propertyTypeToString(PropertiesTypes.Title);
      expect(json['type'], strType);
      expect(json, contains(strType));
      expect((json[strType] as List).length, 1);
    });
  });

  group('RichText property =>', () {
    test('Create an instance of property', () {
      RichTextProp rich = RichTextProp(content: [Text('A'), Text('B')]);

      expect(rich.type, PropertiesTypes.RichText);
      expect(rich.content, isNotEmpty);
      expect(rich.content.length, 2);
      expect(rich.value, isNotEmpty);
      expect(rich.value.length, 2);
    });
    test('Create a json from property', () {
      Map<String, dynamic> json =
          RichTextProp(content: [Text('A'), Text('B')]).toJson();

      String strType = propertyTypeToString(PropertiesTypes.RichText);
      expect(json['type'], strType);
      expect(json, contains(strType));
      expect((json[strType] as List).length, 2);
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

    test('Create an instance with mixed options', () {
      MultiSelectProp multi =
          MultiSelectProp(options: [MultiSelectOption(name: 'A')])
              .addOption(MultiSelectOption(name: 'B'))
              .addOption(MultiSelectOption(name: 'C'));

      expect(multi.type, PropertiesTypes.MultiSelect);
      expect(multi.options, hasLength(3));
      expect(multi.options.first.name, 'A');
      expect(multi.options.last.name, 'C');
    });

    test('Create an option for multi select', () {
      MultiSelectOption option = MultiSelectOption(name: 'A');

      expect(option.name, 'A');
      expect(option.id, isNull);
      expect(option.color, ColorsTypes.Default);
    });

    test('Create an option from json', () {
      Map<String, dynamic> json = {'name': 'A', 'color': 'brown'};
      MultiSelectOption option = MultiSelectOption.fromJson(json);

      expect(option.name, 'A');
      expect(option.id, isNull);
      expect(option.color, ColorsTypes.Brown);
    });

    test('Create a json from property', () {
      Map<String, dynamic> json =
          MultiSelectProp(options: [MultiSelectOption(name: 'A')]).toJson();

      String strType = propertyTypeToString(PropertiesTypes.MultiSelect);
      expect(json['type'], strType);
      expect(json, contains(strType));
      expect(json[strType], contains('options'));
      expect(json[strType]['options'], isList);
      expect(json[strType]['options'], isNotEmpty);
    });

    test('Create a json from option without id', () {
      Map<String, dynamic> json =
          MultiSelectOption(name: 'A', color: ColorsTypes.Brown).toJson();

      expect(json['name'], 'A');
      expect(json['id'], isNull);
      expect(json['color'], contains(colorTypeToString(ColorsTypes.Brown)));
    });

    test('Create a json from option with id', () {
      Map<String, dynamic> json =
          MultiSelectOption(name: 'A', color: ColorsTypes.Brown, id: 'a')
              .toJson();

      expect(json['name'], 'A');
      expect(json['id'], isNotNull);
      expect(json['color'], contains(colorTypeToString(ColorsTypes.Brown)));
    });

    test('Create an options list from json', () {
      List<MultiSelectOption> list = MultiSelectOption.fromListJson([
        {'name': 'A', 'id': 'a'},
        {'name': 'B', 'id': 'b'},
      ]);

      expect(list, isNotEmpty);
      expect(list.length, 2);
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
      'id': 'D[X|',
      'type': 'rich_text',
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

      String strType = propertyTypeToString(PropertiesTypes.Title);
      expect(jsonTest['type'], strType);
      expect(jsonTest, contains(strType));
      expect(jsonTest[strType], isList);
    });

    test('Map details from json response', () {
      RichTextProp prop = RichTextProp.fromJson(jsonDetails);

      expect(prop.content, isNotEmpty);
      expect(prop.content.length, 4);
    });

    test('Create json from details json response', () {
      Map<String, dynamic> jsonTest =
          RichTextProp.fromJson(jsonDetails).toJson();

      String strType = propertyTypeToString(PropertiesTypes.RichText);
      expect(jsonTest['type'], strType);
      expect(jsonTest['id'], isNotNull);
      expect(jsonTest, contains(strType));
      expect(jsonTest[strType], isList);
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

    test('Create json from tags json response', () {
      Map<String, dynamic> multi = MultiSelectProp.fromJson(
              jsonMultiSelectWithSubfield,
              subfield: 'options')
          .toJson();

      String strType = propertyTypeToString(PropertiesTypes.MultiSelect);
      expect(multi['type'], strType);
      expect(multi['id'], isNotNull);
      expect(multi, contains(strType));
      expect(multi[strType], isMap);
    });
  });
}
