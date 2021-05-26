import 'colors.dart';

class Text {
  String _type = 'text';
  String text;
  TextAnnotations? annotations = TextAnnotations();
  Uri? url;

  Text(this.text, {this.annotations, this.url});

  toJson({String textSeparator: ''}) {
    Map<String, dynamic> json = {
      'type': _type,
      'text': {
        'content': '$text$textSeparator',
      },
    };

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

class TextAnnotations {
  bool bold;
  bool italic;
  bool strikethrough;
  bool underline;
  bool code;
  RichTextColors color;

  TextAnnotations({
    this.bold: false,
    this.italic: false,
    this.strikethrough: false,
    this.underline: false,
    this.code: false,
    this.color: RichTextColors.none,
  });

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

  toJson() {
    Map<String, dynamic> json = {
      'color': strColor,
    };

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
