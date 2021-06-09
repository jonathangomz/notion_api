import 'package:notion_api/notion/general/base_properties.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';

/// A representation of the Page notion object.
class Page extends BaseProperties {
  /// The type of this object
  ObjectsTypes object = ObjectsTypes.Page;

  /// The type of this object
  bool archived;

  /// The information of the parent for the page
  PageParent parent = PageParent();

  /// The properties of the page.
  PageProperties properties = PageProperties();
  Map<String, Property> _properties = {};

  /// The content of the page.
  PageChildren children = PageChildren();

  Page({
    this.archived: false,
    required databaseId,
    String title: 'New page from API',
    String id: '',
  }) {
    this.parent.databaseId = databaseId;
    properties.title.add(Text(title));
    this.id = id;
  }

  /// Set the [title] of the page.
  set title(Text value) {
    properties.title.clear();
    properties.title.add(value);
  }

  addProperty({
    required PropertiesTypes type,
  }) {}

  /// Convert this to a json representation valid for the Notion API.
  toJson({bool isResponse: false}) {
    Map<String, dynamic> json = {
      'parent': this.parent.toJson(),
      'properties': this.properties.toJson(),
    };

    if (isResponse) {
      json['object'] = strObject;
      json['id'] = id;
      json['created_time'] = createdTime;
      json['last_edited_time'] = lastEditedTime;
      json['archived'] = archived;
    }

    return json;
  }
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
