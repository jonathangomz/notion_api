import 'rich_text/text.dart';

class Page {
  final PageParent parent = PageParent();
  final PageProperties properties = PageProperties();
  final PageChildren children = PageChildren();

  Page({required databaseId, String? title}) {
    this.parent.databaseId = databaseId;
    properties.title.add(Text(title ?? 'New page from API'));
  }

  set title(Text value) {
    properties.title.clear();
    properties.title.add(value);
  }

  Map<String, dynamic> toJson() => {
        'parent': this.parent.toJson(),
        'properties': this.properties.toJson(),
      };
}

class PageParent {
  String? databaseId;

  toJson() => {
        'database_id': databaseId,
      };
}

class PageProperties {
  List<Text> title = [];

  toJson() => {
        'title': {
          'title': title.map((e) => e.toJson()).toList(),
        },
      };
}

class PageChildren {}
