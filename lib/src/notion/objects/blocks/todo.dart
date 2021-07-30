import '../../general/notion_types.dart';
import '../../rich_text.dart';
import '../block.dart';

/// A representation of the Paragraph Notion block object.
class ToDo extends Block {
  /// The block type. Always ToDo for this.
  @override
  final BlockTypes type = BlockTypes.ToDo;

  List<Text> _content = [];
  List<Block> _children = [];

  /// The separator for the Text objects.
  @Deprecated('Text separation will be by your own')
  String textSeparator;

  /// The checked value.
  bool checked;

  /// The content of this block.
  List<Text> get content => _content.toList();

  /// The children of this block.
  List<Block> get children => _children.toList();

  /// Main to do constructor.
  ///
  /// Can receive a single [text] or a list of [texts]. If both are included also both fields are added to the heading content adding first the [text] field. Also can receive the [children] of the block.
  ///
  /// The [checked] field define if the To do option is marked as done. By default is false.
  ///
  /// _Deprecated:_ [textSeparator] will be removed and the separation will be by your own. This because that's the same way that `Text` & `RichText` works on Flutter. In this way you can add annotations for a part of a word instead of only full words or phrases.
  ///
  /// Also a [textSeparator] can be anexed to separate the texts on the json generated using the `toJson()` function. The separator is used because when the text is displayed is all together without any kind of separation and adding the separator that behavior is avoided. By default the [textSeparator] is an space (" ").
  ToDo({
    Text? text,
    List<Text> texts: const [],
    List<Block> children: const [],
    this.checked: false,
    @deprecated this.textSeparator: ' ',
  }) {
    this._content.addAll([
      if (text != null) text,
      ...texts,
    ]);
    this._children.addAll(children);
  }

  /// ToDo constructor with a single `Text` instance as content.
  ///
  /// This constructor should receive the [content] as a single String.
  ///
  /// Can also receive the [annotations] of the single `Text` element and the [children] of this block.
  ToDo.text(
    String content, {
    TextAnnotations? annotations,
    List<Block> children: const [],
    this.checked: false,
  })  : this.textSeparator = ' ',
        this._content = [Text(content, annotations: annotations)],
        this._children = children;

  // TODO: A function that create an instance of ToDo (or Paragraph or Heading) from a Block.
  //
  // factory ToDo.fromBlock(Block block) {
  //   ToDo todo = ToDo();
  //   todo.checked = block.jsonContent['checked'] ?? bloxk;
  //   todo._content = Text.fromListJson(block.jsonContent['text'] as List);
  //   return todo;
  // }

  /// Add a new [text] to the paragraph content and returns this instance.
  @Deprecated('Use `addText(Block)` instead')
  ToDo add(Text text) {
    this._content.add(text);
    return this;
  }

  /// Add a [text] to the rich text array and returns this instance. Also can receive the [annotations] of the text.
  ToDo addText(String text, {TextAnnotations? annotations}) {
    this._content.add(Text(text, annotations: annotations));
    return this;
  }

  /// Add a new [block] to the children and returns this instance.
  ToDo addChild(Block block) {
    this._children.add(block);
    return this;
  }

  /// Add a list of [blocks] to the children and returns this instance.
  ToDo addChildren(List<Block> blocks) {
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
          'checked': checked,
        }
      };
}
