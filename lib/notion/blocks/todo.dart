import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

import 'paragraph.dart';

/// A representation of the Paragraph notion object.
class ToDo extends Block {
  BlockTypes type = BlockTypes.ToDo;

  /// The paragraph content intself.
  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  /// The checked value
  bool checked;

  ToDo(
      {Text? text,
      List<Text>? texts,
      this.textSeparator: ' ',
      this.checked: false}) {
    if (text != null) {
      this._content.add(text);
    }
    if (texts != null) {
      this._content.addAll(texts);
    }
  }

  factory ToDo.fromBlock(Block block) {
    ToDo todo = ToDo();
    todo.checked = block.jsonContent['checked'];
    todo._content = Text.fromListJson(block.jsonContent['text'] as List);
    return todo;
  }

  /// The string value of the notion type for this object.
  String get strType => NotionUtils.blockTypeToString(type);

  /// The content of this.
  List<Text> get texts => _content.toList();

  /// Add new [text] to the paragraph content
  ToDo addText(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content
              .map((e) => e.toJson(textSeparator: textSeparator))
              .toList(),
          'checked': checked,
        }
      };
}
