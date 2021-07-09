import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';

/// A representation of the Bulleted List Item Notion block object;
class NumberedItem extends Block {
  /// The block type. Always NumberedListItem.
  @override
  final BlockTypes type = BlockTypes.NumberedListItem;

  List<Text> _content = [];

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// Main numbered list item constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field.
  NumberedItem({
    Text? text,
    List<Text>? texts,
  }) {
    if (text != null) {
      _content.add(text);
    }
    if (texts != null) {
      _content.addAll(texts);
    }
  }

  /// Add a new [text] to the rich text array and returns this instance.
  NumberedItem add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
