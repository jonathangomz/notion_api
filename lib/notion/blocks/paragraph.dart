import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Paragraph Notion block object.
class Paragraph extends Block {
  /// The block type. Always Paragraph for this.
  @override
  final BlockTypes type = BlockTypes.Paragraph;

  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  /// The content of this block.
  List<Text> get texts => _content.toList();

  /// Main paragraph constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field.
  ///
  /// Also a [textSeparator] can be anexed to separate the texts on the json generated using the `toJson()` function. The separator is used because when the text is displayed is all together without any kind of separation and adding the separator that behavior is avoided. By default the [textSeparator] is an space (" ").
  Paragraph({
    Text? text,
    List<Text>? texts,
    this.textSeparator: ' ',
  }) {
    if (text != null) {
      this._content.add(text);
    }
    if (texts != null) {
      this._content.addAll(texts);
    }
  }

  /// Add a new [text] to the paragraph content and returns this instance.
  Paragraph add(Text text) {
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
              .toList()
        }
      };
}
