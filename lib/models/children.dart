import 'rich_text/heading.dart';
import 'rich_text/paragraph.dart';

/// A representation of the Children json for the Notion API.
class Children {
  /// The children to be append to the block
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

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {'children': children.map((e) => e.toJson()).toList()};
}
