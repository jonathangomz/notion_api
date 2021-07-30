import 'package:notion_api/notion.dart';
import 'package:test/test.dart';

void main() {
  group('Properties tests =>', () {
    test('Create an empty instance', () {
      Properties properties = Properties.empty();
      expect(properties.isEmpty, true);
    });

    test('Create an instance from json', () {
      Properties properties = Properties.fromJson({
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
        }
      });

      expect(properties.isEmpty, false);
      expect(properties.entries, hasLength(3));
    });
  });
}
