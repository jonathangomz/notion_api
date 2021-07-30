import '../general/notion_types.dart';
import '../objects/block.dart';

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
  /// Can receive a list of [blocks].
  Children({List<Block> blocks: const []}) {
    this._blocks.addAll(blocks);
  }

  /// Constructor that initialize a Children instance with a list of blocks.
  ///
  /// Receive a list of blocks and avoid create first the Children instance and then add the blocks.
  Children.withBlocks(List<Block> blocks) {
    this._blocks.addAll(blocks);
  }

  /// Map a new children instance from a [json] blocks list.
  ///
  /// The blocks with the block type None are excluded because that type represent blocks than can't be mapped as a knowing Notion block type.
  factory Children.fromJson(List<dynamic> json) {
    List<Block> blocks = Block.fromListJson(json);
    blocks.removeWhere((block) => block.type == BlockTypes.None);
    return Children.withBlocks(blocks);
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
      filetered.retainWhere((block) => include.contains(block.type));
    } else if (onlyLeft != null) {
      filetered.retainWhere((element) => element.type == onlyLeft);
    } else if (id != null) {
      filetered.retainWhere((element) => element.id == id);
    }

    return filetered;
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() =>
      {'children': _blocks.map((e) => e.toJson()).toList()};
}
