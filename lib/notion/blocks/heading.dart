import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Heading Notion block object.
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
    List<Text> texts: const [],
    int type: 1,
  })  : this._content = [
          if (text != null) text,
          ...texts,
        ],
        this.type = headingTypeFromInt(type);

  /// Heading constructor with a single `Text` instance as content.
  ///
  /// This constructor should receive the [content] as a single String.
  ///
  /// Can also receive the [annotations] of the single `Text` element and the [children] of this block.
  Heading.text(
    String content, {
    TextAnnotations? annotations,
    int type: 1,
  })  : this._content = [Text(content, annotations: annotations)],
        this.type = headingTypeFromInt(type);

  /// Add a new [text] to the paragraph content and returns this instance.
  @Deprecated('Use `addText(Block)` instead')
  Heading add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Add a [text] to the rich text array and returns this instance. Also can receive the [annotations] of the text.
  Heading addText(String text, {TextAnnotations? annotations}) {
    this._content.add(Text(text, annotations: annotations));
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

  static BlockTypes headingTypeFromInt(int type) {
    switch (type) {
      case 3:
        return BlockTypes.H3;
      case 2:
        return BlockTypes.H2;
      case 1:
      default:
        return BlockTypes.H1;
    }
  }
}
