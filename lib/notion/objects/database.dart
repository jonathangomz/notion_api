import 'package:notion_api/notion/general/base_fields.dart';
import 'package:notion_api/notion/general/lists/properties.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

import 'parent.dart';

/// A representation of the Databse Notion object.
class Database extends BaseFields {
  /// The type of this object. Always Database for this.
  @override
  final ObjectTypes object = ObjectTypes.Database;

  /// The information of the page parent.
  Parent parent = Parent.none();

  /// The title of this database.
  List<Text> title = <Text>[];

  /// The properties of this database.
  Properties properties = Properties();

  /// Main database constructor.
  ///
  /// Can receive the [title], the [createdTime], the [lastEditedTime] and the database [id].
  Database({
    this.title: const <Text>[],
    String createdTime: '',
    String lastEditedTime: '',
    String id: '',
  }) {
    this.id = id;
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  /// Database constructor with defaults parameters.
  ///
  /// Can receive the [parent] (none parent), [title] (empty), the [createdTime] (""), the [lastEditedTime] ("") and the database [id] ("") but every parameter is optional.
  Database.withDefaults({
    this.parent: const Parent.none(),
    this.title: const <Text>[],
    String createdTime: '',
    String lastEditedTime: '',
    String id: '',
  }) {
    this.id = id;
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  /// Database constructor with properties for new Database.
  ///
  /// Can receive the [parent] (required), the [title] (empty) and the [pagesColumnName] ("Name").
  ///
  /// The [pagesColumnName] is the value of the page column header.
  Database.newDatabase({
    required this.parent,
    this.title: const <Text>[],
    String pagesColumnName: 'Name',
  }) : this.properties = Properties(map: {pagesColumnName: TitleProp()}) {
    this.id = id;
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  /// Map a new database instance from a [json] map.
  factory Database.fromJson(Map<String, dynamic> json) => Database.withDefaults(
        id: json['id'] ?? '',
        parent: Parent.fromJson(json['parent'] ?? {}),
        title: Text.fromListJson(json['title'] ?? []),
        createdTime: json['created_time'],
        lastEditedTime: json['last_edited_time'],
      ).addPropertiesFromJson(json['properties'] ?? {});

  /// Add a new database [property] with an specific [name].
  ///
  /// Example:
  /// ```dart
  /// // For the title of a database
  /// this.add(
  ///   name: 'title',
  ///   property: TitleProp(content: [
  ///     Text('Title'),
  ///   ]),
  /// );
  /// ```
  Database addProperty({required String name, required Property property}) {
    this.properties.add(name: name, property: property);
    return this;
  }

  /// Add a group of properties from a [json] map and return this instance.
  Database addPropertiesFromJson(Map<String, dynamic> json) {
    this.properties.addAllFromJson(json);
    return this;
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() => {
        'object': objectTypeToString(this.object),
        'title': title.map((e) => e.toJson()).toList(),
        'parent': parent.toJson(),
        'properties': properties.toJson(),
      };
}
