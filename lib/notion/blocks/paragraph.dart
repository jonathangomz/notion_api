import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the Paragraph notion object.
class Paragraph extends Block {
  BlockTypes type = BlockTypes.Paragraph;

  /// The paragraph content intself.
  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  /// Constructor for paragraph instances.
  /// Can receive a single [text] or a list of [texts] to
  /// include in the content of the paragraph.
  /// Also a [textSeparator] can be anexed to separate the
  /// texts on the json generated.
  ///
  /// The separator is used because when the text is displayed is all together
  /// without any kind of separation and adding the separator that behavior is avoided.
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

  /// The string value of the notion type for this object.
  String get strType => NotionUtils.blockTypeToString(type);

  /// The content of this.
  List<Text> get texts => _content.toList();

  /// Add new [text] to the paragraph content
  Paragraph addText(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a json representation valid for the Notion API.
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
