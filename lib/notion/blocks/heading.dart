import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Heading notion block object.
class Heading extends Block {
  /// The block type. Always H1, H2 or H3 for this.
  @override
  BlockTypes type = BlockTypes.H1;

  List<Text> _content = [];

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// Main heading constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field.
  ///
  /// Also can receive the [type] of the heading as an integer between 1 and 3. Set to 1 by default when no specified or when is out of the range declared before.
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

  /// Add a new [text] to the paragraph content and returns this instance.
  Heading add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content.map((e) => e.toJson()).toList(),
        },
      };
}
