import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/blocks/heading.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';

/// A representation of the children Notion object. Also list of blocks.
class Children {
  List<Block> _blocks = [];

  /// The length of the list children.
  int get length => this._blocks.length;

  /// Returns true if the children list IS empty.
  bool get isEmpty => this._blocks.isEmpty;

  /// Returns true if the children list IS NOT empty.
  bool get isNotEmpty => this._blocks.isNotEmpty;

  /// Main children constructor.
  ///
  /// Can receive a single [heading], a single [paragraph], and a list of [toDo] blocks. If all three are included then the three fields are added to the blocks list adding first the [heading] field, then the [paragraph], and the list of [toDo] at the end.
  Children({
    Heading? heading,
    Paragraph? paragraph,
    List<ToDo>? toDo,
  }) {
    if (heading != null) {
      _blocks.add(heading);
    }
    if (paragraph != null) {
      _blocks.add(paragraph);
    }
    if (toDo != null) {
      _blocks.addAll(toDo.toList());
    }
  }

  /// Map a new children instance from a [json] blocks list.
  ///
  /// The blocks with the block type None are excluded because that type represent blocks than can't be mapped as a knowing Notion block type.
  factory Children.fromJson(List<dynamic> json) {
    Children children = Children();
    children._blocks = Block.fromListJson(json);
    children._blocks = children.filterBlocks(exclude: [BlockTypes.None]);
    return children;
  }

  /// Add a new [block] to the list of blocks and returns this instance.
  Children add(Block block) {
    this._blocks.add(block);
    return this;
  }

  /// Add [blocks] to the list of blocks and returns this instance.
  Children addAll(List<Block> blocks) {
    this._blocks.addAll(blocks);
    return this;
  }

  /// Filter the list of blocks.
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
    filetered.addAll(_blocks);
    if (exclude.isNotEmpty) {
      filetered.removeWhere((block) => exclude.contains(block.type));
    } else if (include.isNotEmpty) {
      filetered.removeWhere((block) => !include.contains(block.type));
    } else if (onlyLeft != null) {
      filetered.removeWhere((element) => element.type != onlyLeft);
    } else if (id != null) {
      filetered.removeWhere((element) => element.id == id);
    }

    return filetered;
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() =>
      {'children': _blocks.map((e) => e.toJson()).toList()};
}