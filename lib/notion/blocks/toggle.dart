import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';

/// A representation of the Bulleted List Item Notion block object;
class Toggle extends Block {
  /// The block type. Always Toggle.
  @override
  final BlockTypes type = BlockTypes.Toggle;

  List<Text> _content = [];
  List<Block> _children = [];

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// The children of this block.
  List<Block> get children => _children.toList();

  /// Main toggle constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field. Also can receive the content of the toggle item.
  Toggle({
    Text? text,
    List<Text>? texts,
    List<Block>? children,
  }) {
    if (text != null) {
      _content.add(text);
    }
    if (texts != null) {
      _content.addAll(texts);
    }
    if (children != null) {
      _children.addAll(children);
    }
  }

  /// Add a new [text] to the rich text array and returns this instance.
  Toggle addText(Text text) {
    this._content.add(text);
    return this;
  }

  /// Add a new [block] to the children block and returns this instance.
  Toggle addChild(Block block) {
    this._children.add(block);
    return this;
  }

  /// Add a list of [blocks] to the children block and returns this instance.
  Toggle addChildren(List<Block> blocks) {
    this._children.addAll(blocks);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content.map((e) => e.toJson()).toList(),
          'children': _children.map((e) => e.toJson()).toList(),
        },
      };
}
