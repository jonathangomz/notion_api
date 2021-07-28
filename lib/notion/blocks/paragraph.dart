import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Paragraph Notion block object.
class Paragraph extends Block {
  /// The block type. Always Paragraph for this.
  @override
  final BlockTypes type = BlockTypes.Paragraph;

  List<Text> _content = [];
  List<Block> _children = [];

  /// The separator for the Text objects.
  @Deprecated('Text separation will be by your own')
  String textSeparator;

  /// The content of this block.
  @Deprecated('Instead use `content`')
  List<Text> get texts => _content.toList();

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// The children of this block.
  List<Block> get children => _children.toList();

  /// Main paragraph constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field. Also can receive the [children] of the block.
  ///
  /// _Deprecated:_ [textSeparator] will be removed and the separation will be by your own. This because that's the same way that `Text` & `RichText` works on Flutter. In this way you can add annotations for a part of a word instead of only full words or phrases.
  ///
  /// Also a [textSeparator] can be anexed to separate the texts on the json generated using the `toJson()` function. The separator is used because when the text is displayed is all together without any kind of separation and adding the separator that behavior is avoided. By default the [textSeparator] is an space (" ").
  Paragraph({
    Text? text,
    List<Text> texts: const [],
    List<Block> children: const [],
    @deprecated this.textSeparator: ' ',
  })  : this._content = [
          if (text != null) text,
          ...texts,
        ],
        this._children = children;

  /// Paragraph constructor with a single `Text` instance as content.
  ///
  /// This constructor should receive the [content] as a single String.
  ///
  /// Can also receive the [annotations] of the single `Text` element and the [children] of this block.
  Paragraph.text(
    String content, {
    TextAnnotations? annotations,
    List<Block> children: const [],
  })  : this.textSeparator = ' ',
        this._content = [Text(content, annotations: annotations)],
        this._children = children;

  /// Add a new [text] to the paragraph content and returns this instance.
  @Deprecated('Use `addText(Block)` instead')
  Paragraph add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Add a [text] to the rich text array and returns this instance. Also can receive the [annotations] of the text.
  Paragraph addText(String text, {TextAnnotations? annotations}) {
    this._content.add(Text(text, annotations: annotations));
    return this;
  }

  /// Add a new [block] to the children and returns this instance.
  Paragraph addChild(Block block) {
    this._children.add(block);
    return this;
  }

  /// Add a list of [blocks] to the children and returns this instance.
  Paragraph addChildren(List<Block> blocks) {
    this._children.addAll(blocks);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: {
          'text': _content
              .map((e) => e.toJson(textSeparator: textSeparator))
              .toList(),
          'children': _children.map((e) => e.toJson()).toList(),
        }
      };
}
