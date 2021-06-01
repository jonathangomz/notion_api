import 'package:notion_api/models/rich_text/notion_types.dart';

import 'text.dart';

/// A representation of the Heading notion objects.
class Heading {
  NotionTypes _type = NotionTypes.H1;
  String _object = 'block';
  List<Text> _content = [];

  Heading(
    String? _text, {
    String? text,
    List<Text>? content,
    int type: 1,
  }) {
    if (content != null) {
      _content.addAll(content);
    } else {
      _content.add(Text(_text ?? text ?? ''));
    }

    switch (type) {
      case 1:
        _type = NotionTypes.H1;
        break;
      case 2:
        _type = NotionTypes.H2;
        break;
      case 3:
        _type = NotionTypes.H3;
        break;
      default:
        _type = NotionTypes.H3;
    }
  }

  /// The string value of the heading type.
  String get type => strType(_type);

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': _object,
        'type': type,
        type: {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
