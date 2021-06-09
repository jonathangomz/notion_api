import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the Heading notion objects.
class Heading extends Block {
  BlocksTypes type = BlocksTypes.H1;
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
        this.type = BlocksTypes.H1;
        break;
      case 2:
        this.type = BlocksTypes.H2;
        break;
      case 3:
        this.type = BlocksTypes.H3;
        break;
      default:
        this.type = BlocksTypes.H3;
    }
  }

  /// The string value of the heading type.
  String get strType => NotionUtils.blockTypeToString(type);

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
