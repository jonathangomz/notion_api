import 'package:notion_api/notion_api.dart' hide MultiSelectOption;
import 'package:notion_api/src/notion/new/database/database_property.dart';
import 'package:test/test.dart';

void main() {
  group('Database Instance =>', () {
    test('Create new database instance', () {
      String title = 'Database title';
      Database database = Database(
        parent: Parent.page(id: 'some_id'),
        title: title,
        properties: DatabaseProperties(
          mainColumnName: 'CustomColumName',
          properties: {
            'Description': DatabaseProperty.RichText(),
          },
        ),
      );

      expect(database.parent.type, ParentType.Page);
      expect(database.title, title);
      expect(database.properties.entries,
          isNotEmpty); // pages column name and 'Description'
    });

    test('Create new instance with data', () {
      Database database = Database.simple(
          parent: Parent.none(),
          title: 'New Database',
          mainColumnName: 'Pages');

      database.addProperty(
        name: 'Tags',
        property: DatabaseProperty.MultiSelect(
          options: [
            MultiSelectOptionDbProp(name: 'Option A'),
            MultiSelectOptionDbProp(name: 'Option B'),
          ],
        ),
      );

      database.addProperty(
        name: 'Details',
        property: DatabaseProperty.RichText(),
      );

      expect(database, isNotNull);
      expect(database.properties.entries.length, 3);
      expect(database.properties.getByName('Tags'), isA<MultiSelectDbProp>());
      expect(database.properties.getByName('Details'), isA<RichTextDbProp>());
      expect(database.properties.getByName('Pages'), isA<TitleDbProp>());
    });

    test('Create json from instance', () {
      Database database = Database.simple(
        parent: Parent.none(),
        title: 'Title',
        mainColumnName: 'Pages',
      );

      database.addProperty(
        name: 'Tags',
        property: DatabaseProperty.MultiSelect(
          options: [
            MultiSelectOptionDbProp(name: 'Option A'),
            MultiSelectOptionDbProp(name: 'Option B'),
          ],
        ),
      );

      database.addProperty(
        name: 'Details',
        property: DatabaseProperty.RichText(),
      );

      Map<String, dynamic> json = database.toJson();

      expect(json, isNotNull);
      expect(json['object'], 'database');
      expect(json['title'], isList);
      expect(json['properties'], isMap);
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
        },
        "parent": {
          "type": "page_id",
          "page_id": "ba3e9659-1de0-4c93-b3ad-78b9b16e5507"
        },
        "url": "https://www.notion.so/8bd452157e1642dd8aad5734a2372518",
      };

      Database database = Database.fromJson(jsonDatabase);

      expect(database.title, isNotEmpty);
      expect(database.id, isNotEmpty);
      expect(database.properties.contains('Tags'), true);
      expect(database.properties.getByName('Tags'), isA<MultiSelectDbProp>());
      expect(database.properties.getByName('Details'), isA<TitleDbProp>());
    });

    test('Map from wrong json', () {
      Map<String, dynamic> wrongJsonDatabase = {};

      expect(() => Database.fromJson(wrongJsonDatabase),
          throwsA(isA<FormatException>()));
    });
  });
}
