import 'types/notion_types.dart';
import '../../utils/utils.dart';

/// A representation of the Rich Text Notion.
class Text {
  String _type = 'text';

  /// The text intself.
  String text;

  /// The annotations of the text.
  TextAnnotations? annotations = TextAnnotations();

  /// The url of the text when the text is a link.
  Uri? url;

  /// Main text constructor.
  ///
  /// Required the [text] itself. Also can receive the [annotations] and/or the [url] of the text.
  Text(this.text, {this.annotations, this.url});

  /// Create a new Text instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  Text.fromJson(Map<String, dynamic> json)
      : this.text = json['text']['content'] ?? '',
        this.annotations = TextAnnotations.fromJson(json['annotations'] ?? {}),
        this.url = json['href'] != null ? Uri.parse(json['href']) : null;

  /// Convert this to a json representation valid for the Notion API.
  ///
  ///_Deprecated:_ [textSeparator] will be removed and the separation will be by your own. This because that's the same way that `Text` & `RichText` works on Flutter. In this way you can add annotations for a part of a word instead of only full words or phrases.
  ///
  /// If a [textSeparator] is given, then it's value (by default a space) is append
  /// at the end of the string to allow be at the same level of other Text objects without
  /// being all together. For example:
  ///
  /// ```dart
  /// // using default (space)
  /// blocks.append(
  ///   to: 'some_block_id',
  ///   children: Children(
  ///     paragraph: Paragraph([
  ///       Text('A'),
  ///       Text('B',)
  ///     ])));
  /// // append => "A B "
  ///
  /// // using custom
  /// blocks.append(
  ///   to: 'some_block_id',
  ///   children: Children(
  ///     paragraph: Paragraph([
  ///       Text('A'),
  ///       Text('B',)
  ///     ],
  ///     textSeparator: '-')));
  /// // append => "A-B-"
  /// ```
  Map<String, dynamic> toJson(
      {@Deprecated('Will not have replacement') String textSeparator: ''}) {
    Map<String, dynamic> json = {
      'type': _type,
      'text': {
        'content': '$text$textSeparator',
      },
    };

    // Null values on fields can break the API call.
    if (annotations != null) {
      json['annotations'] = annotations?.toJson();
    }

    if (url != null) {
      json['link'] = {
        'url': url.toString(),
      };
    }

    return json;
  }

  /// Map a list of texts from a [json] list with dynamics.
  static List<Text> fromListJson(List<dynamic> json) {
    List<Text> texts = [];
    json.forEach((e) => texts.add(Text.fromJson(e)));
    return texts;
  }
}

/// The text style.
class TextAnnotations {
  /// A marker for bold text.
  bool bold;

  /// A marker for italic text.
  bool italic;

  /// A marker for strikethrough text.
  bool strikethrough;

  /// A marker for underline text.
  bool underline;

  /// A marker for code text.
  bool code;

  /// The color of the text. Default by... by default hehe.
  ColorsTypes color;

  /// The string value of the color type.
  String get strColor => colorTypeToString(color);

  /// Main text annotations constructor.
  ///
  /// Can receive if the text will be [bold], [italic], [strikethrough], [underline] and/or [code]. Also the [color] of the text.
  ///
  /// Valid colors are defined by the Colors enum. By default the color type is... Default dah.
  TextAnnotations({
    this.bold: false,
    this.italic: false,
    this.strikethrough: false,
    this.underline: false,
    this.code: false,
    this.color: ColorsTypes.Default,
  });

  /// Create a new text annotation instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  TextAnnotations.fromJson(Map<String, dynamic> json)
      : this.bold = json['bold'] ?? false,
        this.italic = json['italic'] ?? false,
        this.strikethrough = json['strikethrough'] ?? false,
        this.underline = json['underline'] ?? false,
        this.code = json['code'] ?? false,
        this.color = stringToColorType(json['color'] ?? '');

  /// Convert this to a json representation valid for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'color': strColor,
    };

    // Null & false values on fields can break the API call.
    if (bold) {
      json['bold'] = bold;
    }
    if (italic) {
      json['italic'] = italic;
    }
    if (strikethrough) {
      json['strikethrough'] = strikethrough;
    }
    if (underline) {
      json['underline'] = underline;
    }
    if (code) {
      json['code'] = code;
    }

    return json;
  }
}
