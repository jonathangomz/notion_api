import 'package:notion_api/notion_api.dart' hide MultiSelectOption;
import 'package:notion_api/src/notion/new/database/database_property.dart';
import 'package:test/test.dart';

void main() {
  group('Database Instance =>', () {
    group('Create Instance', () {
      group('[Default:', () {
        const String title = 'DatabaseTitle';

        test('new database instance]', () {
          Database database = Database(
            parent: Parent.page(id: 'someId'),
            title: title,
            properties: DatabaseProperties(
              mainColumnName: 'Main',
              properties: {
                'Details': DatabaseProperty.RichText(),
              },
            ),
          );

          expect(database.title, title);
          expect(database.parent.type, ParentType.Page);
          expect(database.properties.entries,
              isNotEmpty); // pages column name and 'Details'
        });
      });

      group('[Usage:', () {
        test('add individual properties]', () {
          Database database = Database.simple(
            parent: Parent.page(id: 'someId'),
            title: 'DatabaseTitle',
            mainColumnName: 'Main',
          );
          expect(database.properties.getByName('Main'), isA<TitleDbProp>());
          expect(database.properties.entries.length, 1);

          // add one more property
          database.addProperty(
            name: 'Tags',
            property: DatabaseProperty.MultiSelect(
              options: [
                MultiSelectOptionDbProp(name: 'Option A'),
                MultiSelectOptionDbProp(name: 'Option B'),
              ],
            ),
          );
          expect(
              database.properties.getByName('Tags'), isA<MultiSelectDbProp>());
          expect(database.properties.entries.length, 2);

          // add one more property
          database.addProperty(
            name: 'Details',
            property: DatabaseProperty.RichText(),
          );
          expect(
              database.properties.getByName('Details'), isA<RichTextDbProp>());

          expect(database.properties.entries.length, 3);
        });

        test('access database properties with type]', () {
          var multiSelectOptions = [
            MultiSelectOptionDbProp(name: 'TagA'),
            MultiSelectOptionDbProp(name: 'TagB'),
            MultiSelectOptionDbProp(name: 'TagC'),
          ];

          Database database = Database(
            parent: Parent.page(id: 'someId'),
            title: 'DatabaseTitle',
            properties: DatabaseProperties(
              mainColumnName: 'Main',
              properties: {
                'Tags': DatabaseProperty.MultiSelect(
                  options: [...multiSelectOptions],
                ),
              },
            ),
          );

          expect(database.parent.type, ParentType.Page);
          expect(database.properties.getByName('Tags').asMultiSelect.options,
              equals(multiSelectOptions)); // pages column name and 'Details'
        });

        test('create json for request]', () {
          Database database = Database(
            parent: Parent.page(id: 'someId'),
            title: 'DatabaseTitle',
            properties: DatabaseProperties(
              mainColumnName: 'Main',
              properties: {
                'Details': DatabaseProperty.RichText(),
              },
            ),
          );

          Map<String, dynamic> json = database.toRequestJson();

          expect(json, isNotNull);

          // required
          expect(json['parent'], allOf([isMap, isNotEmpty]));
          expect(json['title'], allOf([isList, isNotEmpty]));
          expect(json['properties'], allOf([isMap, isNotEmpty]));

          // not required
          expect(json.containsKey('id'), isFalse);
          expect(json.containsKey('url'), isFalse);
        });

        test('create full json]', () {
          Database database = Database(
            parent: Parent.page(id: 'someId'),
            title: 'DatabaseTitle',
            properties: DatabaseProperties(
              mainColumnName: 'Main',
              properties: {
                'Details': DatabaseProperty.RichText(),
              },
            ),
          );

          Map<String, dynamic> json = database.toJson();

          expect(json, isNotNull);
          expect(json['object'], 'database');
          expect(json['title'], isList);
          expect(json['properties'], isNotEmpty);
          expect(json['id'], isEmpty);
          expect(json['url'], isEmpty);
        });
      });
    });

    group('Read from JSON', () {
      group('[Mapping:', () {
        String title = 'test';
        late Database database;
        setUp(() {
          database = Database.fromJson({
            "object": "database",
            "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
            "created_time": "2021-05-19T20:21:11.420Z",
            "last_edited_time": "2021-06-07T23:02:00.000Z",
            "title": [
              {
                "type": "text",
                "text": {"content": title, "link": null},
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
          });
        });

        test('Map full json]', () {
          expect(database.title, isNotEmpty);
          expect(database.id, isNotEmpty);
          expect(database.properties.entries, isNotEmpty);
          expect(Uri.tryParse(database.url)?.hasAbsolutePath ?? false, isTrue);
          expect(database.properties.contains('Tags'), isTrue);
          expect(database.properties.contains('Details'), isTrue);
        });

        test('get database title]', () {
          expect(database.title, title);
        });

        test('get database properties]', () {
          expect(
              database.properties.getByName('Tags'), isA<MultiSelectDbProp>());
          expect(
              database.properties.getByName('Tags'), isA<MultiSelectDbProp>());
          expect(database.properties.getByName('Details'), isA<TitleDbProp>());
        });

        test('access specific properties with type]', () {
          expect(database.properties.getByName('Tags').asMultiSelect.options,
              isList);
        });
      });

      group('[Throw exception:', () {
        test('for empty json]', () {
          expect(() => Database.fromJson({}), throwsA(isA<FormatException>()));
        });

        test('for null required value]', () {
          expect(
              () => Database.fromJson({
                    "object": "database",
                    "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
                    "created_time": "2021-05-19T20:21:11.420Z",
                    "last_edited_time": "2021-06-07T23:02:00.000Z",
                  }),
              throwsA(isA<FormatException>()));
        });
      });
    });
  });
}
