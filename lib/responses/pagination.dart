import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/objects/database.dart';
import 'package:notion_api/utils/utils.dart';

class Pagination {
  String? nextCursor;
  bool hasMore;
  bool isEmpty;
  List<Block>? _blocks;
  List<Database>? _databases;

  /// TODO: made pages class
  List<dynamic>? _pages;

  Pagination({
    this.nextCursor,
    this.hasMore: false,
    this.isEmpty: false,
    List<Block>? blocks,
    List<Database>? databases,
    List<dynamic>? pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json,
      {ObjectsTypes? staticType}) {
    Pagination pagination =
        Pagination(hasMore: json['has_more'], nextCursor: json['next_cursor']);

    // Extract the type of the list
    List listOfUnknowns = json['results'] as List;
    if (listOfUnknowns.length > 0) {
      ObjectsTypes autoType =
          NotionUtils.stringToObjectType(listOfUnknowns.first['object'] ?? '');

      // Map the corresponding list accord to the type
      ObjectsTypes object =
          autoType == ObjectsTypes.None ? staticType ?? autoType : autoType;
      if (object == ObjectsTypes.Block) {
        List<Block> blocks = List<Block>.from(
            (json['results'] as List).map((e) => Block.fromJson(e)));
        pagination._blocks = [...blocks];
      } else if (object == ObjectsTypes.Database) {
        List<Database> databases = List<Database>.from(
            (json['results'] as List).map((e) => Database.fromJson(e)));
        pagination._databases = [...databases];
      } else if (object == ObjectsTypes.Page) {}
    } else {
      pagination.isEmpty = true;
    }

    return pagination;
  }

  List<Block> get blocks => isEmpty ? [] : _blocks!;
  List<Database> get databases => isEmpty ? [] : _databases!;
  List<dynamic> get pages => isEmpty ? [] : _pages!;

  bool get isBlocksList => _blocks != null;
  bool get isDatabasesList => _databases != null;
  bool get isPagesList => _pages != null;

  List<Block> filterBlocks({
    List<BlocksTypes> exclude: const [],
    List<BlocksTypes> include: const [],
    BlocksTypes? onlyLeft,
    String? id,
  }) {
    List<Block> filetered = <Block>[];
    if (isBlocksList) {
      filetered.addAll(_blocks!);
      if (exclude.isNotEmpty) {
        filetered.removeWhere((block) => exclude.contains(block.type));
      } else if (include.isNotEmpty) {
        filetered.removeWhere((block) => !include.contains(block.type));
      } else if (onlyLeft != null) {
        filetered.removeWhere((element) => element.type != onlyLeft);
      } else if (id != null) {
        filetered.removeWhere((element) => element.id == id);
      }
    }
    return filetered;
  }
}
