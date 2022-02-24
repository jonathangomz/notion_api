import 'general/notion_types.dart';
import '../utils/utils.dart';

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

  /// Text constructor with **bold** content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  Text.bold(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(bold: true, color: color);

  /// Text constructor with _italic_ content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  Text.italic(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(italic: true, color: color);

  /// Text constructor with `code` content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  Text.code(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(code: true, color: color);

  /// Text constructor with underline content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  Text.underline(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(underline: true, color: color);

  /// Text constructor to change the default color of a text.
  ///
  /// Only can receive the [text] itself and the [color].
  Text.color(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(color: color);

  /// Text mapper for lists.
  ///
  /// Can receive the list of [texts] the [separator] (by default ", ") and the [lastSeparator] (by default " and ").
  ///
  /// This static method generates a list of "Text" instances in the style of a textual list.
  ///
  /// Example:
  /// ```dart
  /// Paragraph(
  ///   texts: [
  ///     Text('Some programming languages are '),
  ///     ...Text.list(texts: [
  ///       Text.color('Java', color: ColorsTypes.Green),
  ///       Text.color('Javascript', color: ColorsTypes.Blue),
  ///       Text.color('PHP', color: ColorsTypes.Purple),
  ///       Text.color('Dart', color: ColorsTypes.Orange),
  ///     ]),
  ///     Text('.'),
  ///   ],
  /// );
  /// ```
  /// Should print: _"Java, Javascript, PHP and Dart"_ but each element with his own style.
  ///
  /// Otherwise the code should be:
  /// ```dart
  /// Paragraph(
  ///  texts: [
  ///    Text('Some programming languages are '),
  ///    Text.color('Java', color: ColorsTypes.Green),
  ///    Text(', '),
  ///    Text.color('Javascript', color: ColorsTypes.Blue),
  ///    Text(', '),
  ///    Text.color('PHP', color: ColorsTypes.Purple),
  ///    Text(' and '),
  ///    Text.color('Dart', color: ColorsTypes.Orange),
  ///    Text('.'),
  ///  ],
  /// );
  /// ```
  static List<Text> list({
    required List<Text> texts,
    String separator: ', ',
    String lastSeparator: ' and ',
  }) {
    List<Text> list = [];
    texts.asMap().forEach((index, element) {
      if (index == texts.length - 1) {
        // last element
        list.add(element);
      } else {
        if (index == texts.length - 2) {
          // penultimate element
          list.addAll([element, Text(lastSeparator)]);
        } else {
          // any other element
          list.addAll([element, Text(separator)]);
        }
      }
    });
    return list;
  }

  /// Create a new Text instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  Text.fromJson(Map<String, dynamic> json)
      : this.text = json['text']['content'] ?? '',
        this.annotations = TextAnnotations.fromJson(json['annotations'] ?? {}),
        this.url = json['href'] != null ? Uri.parse(json['href']) : null;

  /// Convert this to a json representation valid for the Notion API.
  /// ```
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'type': _type,
      'text': {
        'content': '$text',
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

class RichText {
  String _type = 'text';

  /// The text intself.
  String text;

  /// The annotations of the text.
  TextAnnotations? annotations = TextAnnotations();

  /// The url of the text when the text is a link.
  Uri? url;

  /// Main rich text constructor.
  ///
  /// Required the [text] itself. Also can receive the [annotations] and/or the [url] of the text.
  RichText(this.text, {this.annotations, this.url});

  /// Text constructor with **bold** content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  RichText.bold(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(bold: true, color: color);

  /// Text constructor with _italic_ content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  RichText.italic(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(italic: true, color: color);

  /// Text constructor with `code` content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  RichText.code(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(code: true, color: color);

  /// Text constructor with underline content by default.
  ///
  /// Only can receive the [text] itself and the [color].
  RichText.underline(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(underline: true, color: color);

  /// Text constructor to change the default color of a text.
  ///
  /// Only can receive the [text] itself and the [color].
  RichText.color(
    this.text, {
    ColorsTypes color: ColorsTypes.Default,
  }) : this.annotations = TextAnnotations(color: color);

  /// Text mapper for lists.
  ///
  /// Can receive the list of [texts] the [separator] (by default ", ") and the [lastSeparator] (by default " and ").
  ///
  /// This static method generates a list of "Text" instances in the style of a textual list.
  ///
  /// Example:
  /// ```dart
  /// Paragraph(
  ///   texts: [
  ///     Text('Some programming languages are '),
  ///     ...Text.list(texts: [
  ///       Text.color('Java', color: ColorsTypes.Green),
  ///       Text.color('Javascript', color: ColorsTypes.Blue),
  ///       Text.color('PHP', color: ColorsTypes.Purple),
  ///       Text.color('Dart', color: ColorsTypes.Orange),
  ///     ]),
  ///     Text('.'),
  ///   ],
  /// );
  /// ```
  /// Should print: _"Java, Javascript, PHP and Dart"_ but each element with his own style.
  ///
  /// Otherwise the code should be:
  /// ```dart
  /// Paragraph(
  ///  texts: [
  ///    Text('Some programming languages are '),
  ///    Text.color('Java', color: ColorsTypes.Green),
  ///    Text(', '),
  ///    Text.color('Javascript', color: ColorsTypes.Blue),
  ///    Text(', '),
  ///    Text.color('PHP', color: ColorsTypes.Purple),
  ///    Text(' and '),
  ///    Text.color('Dart', color: ColorsTypes.Orange),
  ///    Text('.'),
  ///  ],
  /// );
  /// ```
  static List<RichText> list({
    required List<RichText> texts,
    String separator: ', ',
    String lastSeparator: ' and ',
  }) {
    List<RichText> list = [];
    texts.asMap().forEach((index, element) {
      if (index == texts.length - 1) {
        // last element
        list.add(element);
      } else {
        if (index == texts.length - 2) {
          // penultimate element
          list.addAll([element, RichText(lastSeparator)]);
        } else {
          // any other element
          list.addAll([element, RichText(separator)]);
        }
      }
    });
    return list;
  }

  /// Create a new Text instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  RichText.fromJson(Map<String, dynamic> json)
      : this.text = json['text']['content'] ?? '',
        this.annotations = TextAnnotations.fromJson(json['annotations'] ?? {}),
        this.url = json['href'] != null ? Uri.parse(json['href']) : null;

  /// Convert this to a json representation valid for the Notion API.
  /// ```
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'type': _type,
      'text': {
        'content': '$text',
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
  static List<RichText> fromListJson(List<dynamic> json) {
    List<RichText> texts = [];
    json.forEach((e) => texts.add(RichText.fromJson(e)));
    return texts;
  }
}

/// The text style.
class RichTextAnnotations {
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

  /// Main rich text annotations constructor.
  ///
  /// Can receive if the text will be [bold], [italic], [strikethrough], [underline] and/or [code]. Also the [color] of the text.
  ///
  /// Valid colors are defined by the Colors enum. By default the color type is... Default dah.
  RichTextAnnotations({
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
  RichTextAnnotations.fromJson(Map<String, dynamic> json)
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
