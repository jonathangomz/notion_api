import '../rich_text/notion_types.dart';
import 'text.dart';

/// A representation of the Paragraph notion object.
class Paragraph {
  String _object = 'block';
  NotionTypes _type = NotionTypes.Paragraph;

  /// The paragraph content intself.
  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  Paragraph({
    Text? text,
    List<Text>? content,
    this.textSeparator: ' ',
  }) {
    if (content != null) {
      this._content.addAll(content);
    } else if (text != null) {
      this._content.add(text);
    } else {
      this._content.add(Text(''));
    }
  }

  /// The string value of the notion type for this object.
  String get type => strType(_type);

  /// Extract the list of Text objects
  List<Text> get texts => _content.toList();

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': _object,
        'type': type,
        type: {
          'text': _content
              .map((e) => e.toJson(textSeparator: textSeparator))
              .toList()
        }
      };
}
