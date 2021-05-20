import 'package:flutter_test/flutter_test.dart';
import 'package:notion_api/models/pages.dart';
import 'package:notion_api/models/rich_text.dart';
import 'package:notion_api/client.dart';

import '../env.dart';

void main() {
  group('Pages', () {
    test('Create a page', () async {
      final NotionClient notion = NotionClient(token: token);

      final Page page = Page(databaseId: test_database_id);
      page.title = Text(content: 'Page from Test');

      var res = await notion.createPage(page);

      expect(res.statusCode, 200);
    });

    test('Retrieve a page', () async {
      final NotionClient notion = NotionClient(token: token);
      var res = await notion.retrievePage(test_page_id);
      expect(res.statusCode, 200);
    });
  });
}
