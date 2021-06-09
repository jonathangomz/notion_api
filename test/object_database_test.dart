import 'package:notion_api/notion/objects/database.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:test/test.dart';

void main() {
  group('Database Instance =>', () {
    test('Create new empty instance', () {
      Database database = Database();

      expect(database, isNotNull);
      expect(database.title, isEmpty);
      expect(database.properties.entries, isEmpty);
      expect(database.object, ObjectTypes.Database);
    });

    test('Create new instance with data', () {
      Database database = Database(title: [Text('Title')])
          .addProperty(
              name: 'Tags',
              property: MultiSelectProp(options: [
                MultiSelectOption(name: 'Option A'),
                MultiSelectOption(name: 'Option B'),
              ]))
          .addProperty(
              name: 'Details',
              property: RichTextProp(content: [
                Text('Detail A'),
                Text('Detail B'),
              ]))
          .addProperty(
              name: 'Name',
              property: TitleProp(content: [Text('Something here...')]));

      expect(database, isNotNull);
      expect(database.title.length, 1);
      expect(database.properties.entries, isNotEmpty);
      expect(database.properties.getProperty('Tags').isMultiSelect, true);
      expect(database.properties.getProperty('Details').isRichText, true);
      expect(database.properties.getProperty('Name').isTitle, true);
    });

    test('Create json from instance', () {
      Map<String, dynamic> database = Database(title: [Text('Title')])
          .addProperty(
              name: 'Tags',
              property: MultiSelectProp(options: [
                MultiSelectOption(name: 'Option A'),
                MultiSelectOption(name: 'Option B'),
              ]))
          .addProperty(
              name: 'Details',
              property: RichTextProp(content: [
                Text('Detail A'),
                Text('Detail B'),
              ]))
          .addProperty(
              name: 'Name',
              property: TitleProp(content: [Text('Something here...')]))
          .toJson();

      expect(database, isNotNull);
      expect(database['object'], 'database');
      expect(database['title'], isList);
      expect(database['properties'], isMap);
    });

    test('Map from json', () {
      var jsonDatabase = {
        "object": "database",
        "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
        "created_time": "2021-05-19T20:21:11.420Z",
        "last_edited_time": "2021-06-07T23:02:00.000Z",
        "title": [
          {
            "type": "text",
            "text": {"content": "test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "test",
            "href": null
          }
        ],
        "properties": {
          "Tags": {
            "id": ">cp;",
            "type": "multi_select",
            "multi_select": {"options": []}
          },
          "Details": {"id": "title", "type": "title", "title": {}}
        }
      };

      Database database = Database.fromJson(jsonDatabase);

      expect(database.title, isNotEmpty);
      expect(database.properties.containsProperty('Tags'), true);
      expect(database.properties.getProperty('Tags').isMultiSelect, true);
      expect(database.properties.containsProperty('Details'), true);
      expect(database.properties.getProperty('Details').isTitle, true);
    });
  });
}
