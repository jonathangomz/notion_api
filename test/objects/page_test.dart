import 'package:notion_api/notion_api.dart';
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

    test('Override page title on set', () {
      Page page = Page.empty();

      const String oldTitle = 'OLD';
      page.title = Text(oldTitle);

      expect(page.properties.getByName('title'), isNotNull);
      expect(page.properties.getByName('title').isTitle, true);
      expect(page.properties.getByName('title').value,
          allOf([isList, hasLength(1)]));
      expect(page.properties.getByName('title').value.first.text, oldTitle);

      const String newTitle = 'NEW';
      page.title = Text(newTitle);

      expect(page.properties.getByName('title'), isNotNull);
      expect(page.properties.getByName('title').isTitle, true);
      expect(page.properties.getByName('title').value,
          allOf([isList, hasLength(1)]));
      expect(page.properties.getByName('title').value.first.text, newTitle);
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
      expect(page.properties.getByName('Tags').isMultiSelect, true);
      expect(page.properties.getByName('Details').isRichText, true);
      expect(page.properties.getByName('Name').isTitle, true);
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

    test('Create json with & without children field', () {
      Parent parent = Parent(type: ParentType.Database, id: 'DATABASE_ID');

      Page pageWithChildren = Page(
          parent: parent,
          children: Children.withBlocks([
            Heading(text: Text('A')),
          ]));
      Page pageWithoutChildren = Page(parent: parent);

      Map<String, dynamic> jsonWithChildren = pageWithChildren.toJson();
      Map<String, dynamic> jsonWithoutChildren = pageWithoutChildren.toJson();

      expect(jsonWithChildren, contains('children'));
      expect(jsonWithoutChildren, isNot(contains('children')));
    });

    test('Map page isntance from json', () {
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
      expect(page.properties.getByName('title').isTitle, true);
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
      expect(page.properties.getByName('title').isTitle, true);
      expect(page.properties.getByName('title').value, isList);
    });
  });

  group('Parent tests =>', () {
    test('Create an empty instance', () {
      Parent parent = Parent.none();
      expect(parent.type, ParentType.None);
      expect(parent.id, isEmpty);
    });

    test('Create an instance with data', () {
      Parent parent = Parent(type: ParentType.Page, id: 'ABC');
      expect(parent.id, 'ABC');
      expect(parent.type, ParentType.Page);
    });

    test('Create page parent from constructor', () {
      Parent parent = Parent.page(id: 'ABC');
      expect(parent.type, ParentType.Page);
    });

    test('Create workspace parent from constructor', () {
      Parent parent = Parent.workspace();
      expect(parent.type, ParentType.Workspace);
      expect(parent.id, isEmpty);
    });

    test('Json should not have id for workspace', () {
      Map<String, dynamic> json = Parent.workspace().toJson();
      expect(json, isNot(contains('database_id')));
      expect(json, isNot(contains('page_id')));
    });
  });
}
