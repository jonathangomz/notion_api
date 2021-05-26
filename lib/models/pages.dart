import 'rich_text/text.dart';

/// A representation of the Page notion object.
class Page {
  /// The information of the parent for the page
  final PageParent parent = PageParent();

  /// The properties of the page.
  final PageProperties properties = PageProperties();

  /// The content of the page.
  final PageChildren children = PageChildren();

  Page({required databaseId, String? title}) {
    this.parent.databaseId = databaseId;
    properties.title.add(Text(title ?? 'New page from API'));
  }

  /// Set the [title] of the page.
  set title(Text value) {
    properties.title.clear();
    properties.title.add(value);
  }

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'parent': this.parent.toJson(),
        'properties': this.properties.toJson(),
      };
}

/// A representation of the Page parent json field for the Notion API.
class PageParent {
  /// The databaseId parent.
  String? databaseId;

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'database_id': databaseId,
      };
}

/// A representation of the Page properties field for the Notion API.
class PageProperties {
  /// The title for the page.
  List<Text> title = [];

  /// Convert this to a json representation valid for the Notion API.
  toJson() => {
        'title': {
          'title': title.map((e) => e.toJson()).toList(),
        },
      };
}

/// A representation of the Page children field for the Notion API.
class PageChildren {}
