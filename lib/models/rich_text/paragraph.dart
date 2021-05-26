import 'notion_types.dart';
import 'text.dart';

class Paragraph {
  String _object = 'block';
  NotionTypes _type = NotionTypes.Paragraph;
  List<Text> content = [];
  String textSeparator;

  Paragraph(this.content, {this.textSeparator: ' '});

  String get type {
    switch (_type) {
      case NotionTypes.Paragraph:
        return 'paragraph';
      default:
        return 'paragraph';
    }
  }

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
