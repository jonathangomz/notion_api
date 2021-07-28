import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';

/// A representation of the Bulleted List Item Notion block object;
class BulletedListItem extends Block {
  /// The block type. Always BulletedListItem.
  @override
  final BlockTypes type = BlockTypes.BulletedListItem;

  List<Text> _content = [];
  List<Block> _children = [];

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// The children of this block.
  List<Block> get children => _children.toList();

  /// Main bulleted list item constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field. Also can receive the [children] of the block.
  BulletedListItem({
    Text? text,
    List<Text> texts: const [],
    List<Block> children: const [],
  })  : this._content = [
          if (text != null) text,
          ...texts,
        ],
        this._children = children;

  /// BulletedListItem constructor with a single `Text` instance as content.
  ///
  /// This constructor should receive the [content] as a single String.
  ///
  /// Can also receive the [annotations] of the single `Text` element and the [children] of this block.
  BulletedListItem.text(
    String content, {
    TextAnnotations? annotations,
    List<Block> children: const [],
  })  : this._content = [Text(content, annotations: annotations)],
        this._children = children;

  /// Add a [text] to the rich text array and returns this instance. Also can receive the [annotations] of the text.
  BulletedListItem addText(String text, {TextAnnotations? annotations}) {
    this._content.add(Text(text, annotations: annotations));
    return this;
  }

  /// Add a new [block] to the children and returns this instance.
  BulletedListItem addChild(Block block) {
    this._children.add(block);
    return this;
  }

  /// Add a list of [blocks] to the children and returns this instance.
  BulletedListItem addChildren(List<Block> blocks) {
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
