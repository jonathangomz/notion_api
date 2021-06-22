import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/lists/pagination.dart';
import 'package:test/test.dart';

import 'data.dart';

void main() {
  group('Paginations tests =>', () {
    test('Databases list', () async {
      Pagination pag = Pagination.fromJson({
        "object": "list",
        "results": [],
        "next_cursor": null,
        "has_more": false
      });

      expect(pag.isEmpty, true);
      expect(pag.list, isEmpty);
    });

    test('Blocks list', () async {
      Pagination pag = Pagination.fromJson(longBlocksJsonList);

      expect(pag.isEmpty, false);
      expect(pag.isBlocksList, true);
      expect(pag.blocks, isNotEmpty);
      expect(pag.list, isNotEmpty);
      expect(pag.list.first.object, ObjectTypes.Block);
    });

    test('Blocks list with filter', () async {
      Pagination pag = Pagination.fromJson(longBlocksJsonList);

      List<Block> filtered = pag.filterBlocks(onlyLeft: BlockTypes.H1);

      expect(filtered.length, lessThan(pag.list.length));
    });

    test('Wrong json', () {
      Pagination pag = Pagination.fromJson({});

      expect(pag.nextCursor, isNull);
      expect(pag.hasMore, false);
      expect(pag.isEmpty, true);
      expect(pag.list, isEmpty);
    });
  });
}
