import 'text.dart';

/// The basic heading types.
enum HeadingTypes {
  H1,
  H2,
  H3,
}

/// A representation of the Heading notion objects.
class Heading {
  HeadingTypes _type = HeadingTypes.H1;
  String _object = 'block';
  List<Text> _content = [];

  Heading(
    String? _text, {
    HeadingTypes? type,
    String? text,
    List<Text>? content,
  }) {
    if (content != null) {
      _content.addAll(content);
    } else {
      _content.add(Text(_text ?? text ?? ''));
    }

    if (type != null) {
      _type = type;
    }
  }

  /// The string value of the heading type.
  String get type {
    switch (_type) {
      case HeadingTypes.H1:
        return 'heading_1';
      case HeadingTypes.H2:
        return 'heading_2';
      case HeadingTypes.H3:
        return 'heading_3';
    }
  }

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': _object,
        'type': type,
        '$type': {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
