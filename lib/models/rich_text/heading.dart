import 'text.dart';

enum HeadingTypes {
  H1,
  H2,
  H3,
}

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

  toJson() => {
        'object': _object,
        'type': type,
        '$type': {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
