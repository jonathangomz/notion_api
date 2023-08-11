import 'package:notion_api/notion_api.dart';
import 'package:notion_api/src/notion/objects/object.dart';
import 'package:test/test.dart';

void main() {
  group('Base fields tests =>', () {
    test('Create an instance from json', () {
      Object base = Object.fromJson({
        "object": "database",
        "id": "386da3c6-46bb-4581-8807-1fdb2fbbf447",
        "created_time": "2021-05-19T20:21:11.420Z",
        "last_edited_time": "2021-06-07T23:02:00.000Z",
        "title": [],
      });

      expect(base.object, ObjectTypes.Database);
      expect(base.id, "386da3c6-46bb-4581-8807-1fdb2fbbf447");
      expect(base.createdTime!.toIso8601String(), "2021-05-19T20:21:11.420Z");
      expect(
          base.lastEditedTime!.toIso8601String(), "2021-06-07T23:02:00.000Z");
    });
  });
}
