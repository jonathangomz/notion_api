import 'package:notion_api/notion/general/base_fields.dart';
import 'package:notion_api/notion/general/lists/properties.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/lists/children.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the Page Notion object.
class Page extends BaseFields {
  /// The type of this object. Always Page for this.
  @override
  ObjectTypes object = ObjectTypes.Page;

  /// The information of the page parent.
  Parent parent;

  /// The field that defined if is archived or not.
  bool archived;

  /// The content of the page.
  Children? children;

  /// The properties of the page.
  final Properties properties = Properties();

  /// Main constructor for the page.
  ///
  /// This constructor require the [parent] and can
  /// receive if is [archived] and his [children].
  /// Also the [id] of the page and the [title].
  ///
  /// The [children] and [title] fields are defined
  /// for when a new page is created.
  Page({
    required this.parent,
    this.archived: false,
    this.children,
    String id: '',
    Text? title,
  }) {
    this.id = id;
    if (title != null) {
      this.title = title;
    }
    if (this.children == null) {
      this.children = Children();
    }
  }

  /// Constructor for empty page.
  Page.empty()
      : this.parent = Parent.none(),
        this.archived = false;

  /// Contructor from json.
  factory Page.fromJson(Map<String, dynamic> json) {
    Page page = Page(
      id: json['id'] ?? '',
      parent: Parent.fromJson(json['parent'] ?? {}),
      archived: json['archived'] ?? false,
    ).addPropertiesFromJson(json['properties'] ?? {});
    page.setBaseProperties(
        createdTime: json['created_time'] ?? '',
        lastEditedTime: json['last_edited_time'] ?? '');
    return page;
  }

  /// Set the [title] of the page.
  set title(Text title) {
    // Only set one title at a time.
    if (this.properties.contains('title')) {
      this.properties.remove('title');
    }

    this.properties.add(name: 'title', property: TitleProp(content: [title]));
  }

  /// Add a [property] with a specific [name] to this properties.
  Page addProperty({required String name, required Property property}) {
    this.properties.add(name: name, property: property);
    return this;
  }

  /// Add a multiples properties from a [json] to this properties.
  Page addPropertiesFromJson(Map<String, dynamic> json) {
    this.properties.addAllFromJson(json);
    return this;
  }

  /// Convert this to a json representation valid for the Notion API.
  Map<String, dynamic> toJson({bool isResponse: false}) {
    Map<String, dynamic> json = {
      'parent': this.parent.toJson(),
      'properties': this.properties.toJson(),
    };

    // Add response json fields.
    if (isResponse) {
      json['object'] = strObject;
      json['id'] = id;
      json['created_time'] = createdTime;
      json['last_edited_time'] = lastEditedTime;
      json['archived'] = archived;
    }

    // Only add children to json if have items.
    if (this.children != null && this.children!.isNotEmpty) {
      json['children'] = this.children!.toJson();
    }

    return json;
  }
}

/// A representation of the parent json field for the Notion API.
class Parent {
  /// The type of parent.
  ParentType type;

  /// The id of the parent.
  String id;

  /// Main constructor for the page parent.
  ///
  /// This constructor require the parent [id] and the [type] of parent.
  /// Possible types are defined by ParentType enum.
  Parent({required this.type, required this.id});

  /// Constructor for empty parent.
  Parent.none()
      : this.type = ParentType.None,
        this.id = '';

  /// Constructor for workspace parent.
  Parent.workspace()
      : this.type = ParentType.Workspace,
        this.id = '';

  /// Constructor for database parent.
  ///
  /// This constructor require the database [id].
  Parent.database({required this.id}) : this.type = ParentType.Database;

  /// Constructor for page parent.
  ///
  /// This constructor require the page [id].
  Parent.page({required this.id}) : this.type = ParentType.Page;

  /// Constructor parent from json.
  ///
  /// This constructor receive a [json] from where the information
  /// is extracted.
  Parent.fromJson(Map<String, dynamic> json)
      : this.id = json[json['type']] ?? '',
        this.type = stringToParentType(json['type'] ?? '');

  /// The string value of this type.
  String get strType => parentTypeToString(this.type);

  /// Convert this to a json representation valid for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': this.strType};

    // Only database and page types contain an id.
    if (this.type == ParentType.Database || this.type == ParentType.Page) {
      json[strType] = this.id;
    }

    return json;
  }
}
