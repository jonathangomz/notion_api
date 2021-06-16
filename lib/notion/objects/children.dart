import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';

import '../blocks/heading.dart';
import '../blocks/paragraph.dart';
import '../blocks/todo.dart';

/// A representation of the Children json for the Notion API.
class Children {
  /// The children to be append to the block
  List<Block> _children = [];

  /// Get the length of the list children.
  int get length => this._children.length;

  /// Get if the children list IS empty
  bool get isEmpty => this._children.isEmpty;

  /// Get if the children list IS NOT empty
  bool get isNotEmpty => this._children.isNotEmpty;

  Children({
    Heading? heading,
    Paragraph? paragraph,
    List<ToDo>? toDo,
  }) {
    if (heading != null) {
      _children.add(heading);
    }
    if (paragraph != null) {
      _children.add(paragraph);
    }
    if (toDo != null) {
      _children.addAll(toDo.toList());
    }
  }

  factory Children.fromJson(List<dynamic> json) {
    Children children = Children();
    children._children = Block.fromListJson(json);
    children._children = children.filterBlocks(exclude: [BlockTypes.None]);
    return children;
  }

  Children add(Block block) {
    this._children.add(block);
    return this;
  }

  List<Block> filterBlocks({
    List<BlockTypes> exclude: const [],
    List<BlockTypes> include: const [],
    BlockTypes? onlyLeft,
    String? id,
  }) {
    List<Block> filetered = <Block>[];
    filetered.addAll(_children);
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

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {'children': _children.map((e) => e.toJson()).toList()};
}
