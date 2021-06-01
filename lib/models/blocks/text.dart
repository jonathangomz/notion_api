import '../rich_text/colors.dart';

/// A representation of the Text notion object.
class Text {
  String _type = 'text';

  /// The text intself.
  String text;

  /// The styles of the text.
  TextAnnotations? annotations = TextAnnotations();

  /// The url of the text when the text is a link.
  Uri? url;

  Text(this.text, {this.annotations, this.url});

  /// Convert this to a json representation valid for the Notion API.
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
  toJson({String textSeparator: ''}) {
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
}

/// The text styles.
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

  /// The color of the text.
  RichTextColors color;

  TextAnnotations({
    this.bold: false,
    this.italic: false,
    this.strikethrough: false,
    this.underline: false,
    this.code: false,
    this.color: RichTextColors.none,
  });

  /// The string value of the color.
  String get strColor {
    switch (color) {
      case RichTextColors.none:
        return 'default';
      case RichTextColors.gray:
        return 'gray';
      case RichTextColors.brown:
        return 'brown';
      case RichTextColors.orange:
        return 'orange';
      case RichTextColors.yellow:
        return 'yellow';
    }
  }

  /// Convert this to a json representation valid for the Notion API.
  toJson() {
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
