import '../../utils/utils.dart';
import '../general/notion_types.dart';
import '../objects/block.dart';
import '../objects/database.dart';

/// A representation of the pagination response from the Notion API. Also list of objects.
class Pagination {
  /// The cursor to the next page.
  String? nextCursor;

  /// The marker to know if has more pages.
  bool hasMore;

  /// The marker to know if is empty.
  bool isEmpty;

  List<Block>? _blocks;
  List<Database>? _databases;

  get list {
    if (this.isEmpty) {
      return [];
    } else if (this.isBlocksList) {
      return this.blocks;
    } else if (this.isDatabasesList) {
      return this.databases;
    }
  }

  /// The legth of the list.
  int get length => this.list.length;

  /// The list of blocks for when the response is for blocks.
  List<Block> get blocks => isEmpty ? [] : _blocks!;

  /// The list of databases for when the response is for databases.
  List<Database> get databases => isEmpty ? [] : _databases!;

  /// Returns true if the result is a list of blocks.
  bool get isBlocksList => _blocks != null;

  /// Returns true if the result is a list of databases.
  bool get isDatabasesList => _databases != null;

  /// Main pagination constructor.
  ///
  /// Can receive the [nextCursor], if [hasMore] pages, if [isEmpty] and the corresponding list: [blocks], [databases] or [pages].
  Pagination({
    this.nextCursor,
    this.hasMore: false,
    this.isEmpty: false,
    List<Block>? blocks,
    List<Database>? databases,
  });

  /// Map a new pagination instance from a [json] map.
  factory Pagination.fromJson(Map<String, dynamic> json,
      {ObjectTypes? staticType}) {
    Pagination pagination = Pagination(
        hasMore: json['has_more'] ?? false, nextCursor: json['next_cursor']);

    // Extract the type of the list
    List listOfUnknowns =
        json['results'] != null ? json['results'] as List : [];
    if (listOfUnknowns.length > 0) {
      ObjectTypes autoType =
          stringToObjectType(listOfUnknowns.first['object'] ?? '');

      // Map the corresponding list accord to the type
      ObjectTypes object =
          autoType == ObjectTypes.None ? staticType ?? autoType : autoType;
      if (object == ObjectTypes.Block) {
        List<Block> blocks = Block.fromListJson(json['results'] as List);
        pagination._blocks = [...blocks];
      } else if (object == ObjectTypes.Database) {
        List<Database> databases = List<Database>.from(
            (json['results'] as List).map((e) => Database.fromJson(e)));
        pagination._databases = [...databases];
      } else if (object == ObjectTypes.Page) {}
    } else {
      pagination.isEmpty = true;
    }

    return pagination;
  }

  /// Filter the list of blocks children.
  ///
  /// Can [exclude] or [include] blocks of a certain types. Also can [onlyLeft] blocks of one type or search blocks by [id].
  ///
  /// If all fields are included then all filters are applied as a chain following the next order: [exclude], [include], [onlyLeft], and the [id].
  List<Block> filterBlocks({
    List<BlockTypes> exclude: const [],
    List<BlockTypes> include: const [],
    BlockTypes? onlyLeft,
    String? id,
  }) {
    List<Block> filetered = <Block>[];
    if (this.isBlocksList) {
      filetered.addAll(_blocks!);
      if (exclude.isNotEmpty) {
        filetered.removeWhere((block) => exclude.contains(block.type));
      } else if (include.isNotEmpty) {
        filetered.retainWhere((block) => include.contains(block.type));
      } else if (onlyLeft != null) {
        filetered.retainWhere((element) => element.type == onlyLeft);
      } else if (id != null) {
        filetered.retainWhere((element) => element.id == id);
      }
    }

    return filetered;
  }

  /// Filter the list of databases children.
  ///
  /// Can [exclude] or [include] databases with certain ids. Also can search search databases by [id].
  ///
  /// If all fields are included then all filters are applied as a chain following the next order: [exclude], [include], and the [id].
  List<Database> filterDatabases({
    List<String> exclude: const [],
    List<String> include: const [],
    String? id,
  }) {
    List<Database> filetered = <Database>[];
    if (this.isDatabasesList) {
      filetered.addAll(_databases!);
      if (exclude.isNotEmpty) {
        filetered.removeWhere((database) => exclude.contains(database.id));
      } else if (include.isNotEmpty) {
        filetered.retainWhere((database) => include.contains(database.id));
      } else if (id != null) {
        filetered.retainWhere((element) => element.id == id);
      }
    }

    return filetered;
  }
}
