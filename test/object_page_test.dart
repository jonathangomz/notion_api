import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/objects/pages.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Page Instance =>', () {
    test('Create new empty instance', () {
      Page page = Page.empty();

      expect(page, isNotNull);
      expect(page.children, isNull);
      expect(page.archived, false);
      expect(page.object, ObjectTypes.Page);
      expect(page.parent.type, ParentType.None);
      expect(page.properties.isEmpty, true);
    });

    test('Create new instance with data', () {
      Page page =
          Page(parent: Parent.database(id: 'asdasdasd-asdasdasdas-asdasdasd'))
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

      expect(page.properties.entries, isNotEmpty);
      expect(page.properties.get('Tags').isMultiSelect, true);
      expect(page.properties.get('Details').isRichText, true);
      expect(page.properties.get('Name').isTitle, true);
    });

    test('Create json (for API) from instance', () {
      Map<String, dynamic> page =
          Page(parent: Parent.database(id: 'asdasdasd-asdasdasdas-asdasdasd'))
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

      expect(page['object'], isNull);
      expect(page['id'], isNull);
      expect(page['created_time'], isNull);
      expect(page['last_edited_time'], isNull);
      expect(page['archived'], isNull);
      expect(page['parent']['type'], parentTypeToString(ParentType.Database));
      expect(page['properties'], isMap);
    });

    test('Create json (from Response) from instance', () {
      var json = {
        "object": "page",
        "id": "c3d51019-4470-443b-a141-94a3a1a54f60",
        "created_time": "2021-05-19T22:11:49.607Z",
        "last_edited_time": "2021-05-19T22:11:00.000Z",
        "parent": {
          "type": "database_id",
          "database_id": "386da3c6-46bb-4581-8807-1fdb2fbbf447"
        },
        "archived": true,
        "properties": {
          "This is a test": {
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
          }
        }
      };
      Map<String, dynamic> page = Page.fromJson(json).toJson(isResponse: true);

      expect(page['object'], allOf([isNotNull, isNotEmpty]));
      expect(page['id'], allOf([isNotNull, isNotEmpty]));
      expect(page['created_time'], allOf([isNotNull, isNotEmpty]));
      expect(page['last_edited_time'], allOf([isNotNull, isNotEmpty]));
      expect(page['archived'], true);
      expect(page['parent']['type'], parentTypeToString(ParentType.Database));
      expect(page['properties'], isMap);
      expect(page['children'], isNull);
    });

    test('Map from json', () {
      var json = {
        "object": "page",
        "id": "c3d51019-4470-443b-a141-94a3a1a54f60",
        "created_time": "2021-05-19T22:11:49.607Z",
        "last_edited_time": "2021-05-19T22:11:00.000Z",
        "parent": {
          "type": "database_id",
          "database_id": "386da3c6-46bb-4581-8807-1fdb2fbbf447"
        },
        "archived": true,
        "properties": {
          "title": {
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
          }
        }
      };

      Page page = Page.fromJson(json);

      expect(page.id, isNotEmpty);
      expect(page.parent.type, ParentType.Database);
      expect(page.properties.contains('title'), true);
      expect(page.properties.get('title').isTitle, true);
    });

    test('Map from wrong json', () {
      Map<String, dynamic> wrongJsonDatabase = {};

      Page page = Page.fromJson(wrongJsonDatabase);

      expect(page.id, isEmpty);
      expect(page.properties.contains('title'), false);
      expect(page.parent.type, ParentType.None);
    });

    test('Add properties from json', () {
      Page page = Page.empty().addPropertiesFromJson({
        "title": {"id": "title", "type": "title", "title": {}}
      });

      expect(page.properties.contains('title'), true);
      expect(page.properties.get('title').isTitle, true);
      expect(page.properties.get('title').value, isList);
    });
  });
}
