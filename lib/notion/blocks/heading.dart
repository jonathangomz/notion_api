import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the Heading notion objects.
class Heading extends Block {
  BlockTypes type = BlockTypes.H1;
  List<Text> _content = [];

  Heading({
    Text? text,
    List<Text>? texts,
    int type: 1,
  }) {
    if (text != null) {
      _content.add(text);
    }
    if (texts != null) {
      _content.addAll(texts);
    }

    switch (type) {
      case 3:
        this.type = BlockTypes.H3;
        break;
      case 2:
        this.type = BlockTypes.H2;
        break;
      case 1:
      default:
        this.type = BlockTypes.H1;
    }
  }

  /// The string value of the heading type.
  String get strType => NotionUtils.blockTypeToString(type);

  /// The content of this.
  List<Text> get texts => _content.toList();

  /// Add new [text] to the paragraph content
  Heading addText(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a json representation valid for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
