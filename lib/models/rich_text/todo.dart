import 'package:notion_api/models/rich_text/paragraph.dart';

import 'notion_types.dart';
import 'text.dart';

/// A representation of the Paragraph notion object.
class ToDo {
  String _object = 'block';
  NotionTypes _type = NotionTypes.ToDo;

  /// The paragraph content intself.
  List<Text> _content = [];

  /// The separator for the Text objects.
  String textSeparator;

  /// The checked value
  bool checked;

  ToDo(
      {Text? text,
      Paragraph? content,
      this.textSeparator: ' ',
      this.checked: false}) {
    if (content != null) {
      this._content.addAll(content.texts);
    } else if (text != null) {
      this._content.add(text);
    } else {
      this._content.add(Text(''));
    }
  }

  /// The string value of the notion type for this object.
  String get type => strType(_type);

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': _object,
        'type': type,
        type: {
          'text': _content
              .map((e) => e.toJson(textSeparator: textSeparator))
              .toList(),
          'checked': checked,
        }
      };
}
