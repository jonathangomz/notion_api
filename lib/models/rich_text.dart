import 'package:notion_api/models/users.dart';

enum RichTextType {
  mention,
  text,
  equation,
  url,
}

enum RichTextColors {
  gray,
  brown,
  orange,
  yellow,
}

class RichTextAnnotations {
  bool bold;
  bool italic;
  bool strikethrough;
  bool underline;
  bool code;
  RichTextColors color;
}

class RichText {
  String plainText;
  String href;
  RichTextAnnotations annotations;
  RichTextType type;

  toJson() => {
        'plain_text': plainText,
        'href': href,
        'annotations': annotations,
        'type': type,
      };
}

class Text extends RichText {
  String content;

  Text({content}) : this.content = content;

  toJson() {
    Map<String, dynamic> json = super.toJson();
    json['text'] = {
      'content': content,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}

class Link extends Text {
  RichTextType type = RichTextType.url;
  String url;
}

class Mention extends RichText {
  RichTextType type = RichTextType.mention;
}

class UserMention extends Mention {
  PeopleUser user;
}

class Equation extends RichText {
  String expression;
}
