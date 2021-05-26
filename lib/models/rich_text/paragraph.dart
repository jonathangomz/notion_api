import 'notion_types.dart';
import 'text.dart';

/// A representation of the Paragraph notion object.
class Paragraph {
  String _object = 'block';
  NotionTypes _type = NotionTypes.Paragraph;

  /// The paragraph content intself.
  List<Text> content = [];

  /// The separator for the Text objects.
  String textSeparator;

  Paragraph(this.content, {this.textSeparator: ' '});

  /// The string value of the notion type for this object.
  String get type {
    switch (_type) {
      case NotionTypes.Paragraph:
        return 'paragraph';
      default:
        return 'paragraph';
    }
  }

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': _object,
        'type': type,
        type: {
          'text': content
              .map((e) => e.toJson(textSeparator: textSeparator))
              .toList()
        }
      };
}
