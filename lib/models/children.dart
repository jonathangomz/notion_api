import 'rich_text/heading.dart';
import 'rich_text/paragraph.dart';

class Children {
  List<dynamic> children = [];

  Children({
    Heading? heading,
    Paragraph? paragraph,
  }) {
    if (heading != null) {
      children.add(heading);
    }
    if (paragraph != null) {
      children.add(paragraph);
    }
  }

  toJson() => {'children': children.map((e) => e.toJson()).toList()};
}
