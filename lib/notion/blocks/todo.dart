import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Paragraph Notion block object.
class ToDo extends Block {
  /// The block type. Always ToDo for this.
  @override
  BlockTypes type = BlockTypes.ToDo;

  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  /// The checked value.
  bool checked;

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// Main to do constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field.
  ///
  /// Also a [textSeparator] can be anexed to separate the texts on the json generated using the `toJson()` function. The separator is used because when the text is displayed is all together without any kind of separation and adding the separator that behavior is avoided. By default the [textSeparator] is an space (" ").
  ///
  /// The [checked] field define if the To do option is marked as done. By default is false.
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

  // TODO: A function that create an instance of ToDo (or Paragraph or Heading) from a Block.
  //
  // factory ToDo.fromBlock(Block block) {
  //   ToDo todo = ToDo();
  //   todo.checked = block.jsonContent['checked'] ?? bloxk;
  //   todo._content = Text.fromListJson(block.jsonContent['text'] as List);
  //   return todo;
  // }

  /// Add a new [text] to the paragraph content and returns this instance.
  ToDo add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
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
