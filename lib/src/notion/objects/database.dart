import 'package:notion_api/src/notion/new/database/database_property.dart';

import '../../utils/utils.dart';
import '../general/exports.dart';
import '../rich_text.dart';
import 'object.dart';
import 'parent.dart';

/// A representation of the Databse Notion object.
class Database extends Object {
  /// The type of this object. Always Database for this.
  @override
  final ObjectTypes object = ObjectTypes.Database;

  /// The title of this database.
  final List<RichText> _title = <RichText>[];

  /// The properties of this database.
  DatabaseProperties properties;

  /// The information of the page parent.
  Parent parent;

  /// The URL of the Notion datanase.
  String url;

  String get title => _title.first.text;

  /// Map a new database instance for a new request.
  ///
  /// Receive the database [parent] and [properties], and also con receive the database [title] but is optional (by default will set to "Untitled").
  ///
  /// We recommend to use `Properties.forDatabase` on the [properties] field to be sure that any required property is missing, like the Title property.
  Database({
    required this.parent,
    required this.properties,
    String? title,
  }) : url = '' {
    if (parent.type != ParentType.Page) throw 'The parent should be a page';
    if (title != null) _title.add(RichText(title));
  }

  /// Main database constructor.
  ///
  /// Can receive all the available properties for a database which are the [id], [createdTime], [lastEditedTime], [title], [properties], [parent] and [url].
  Database.constructor({
    // Object properties
    required String id,
    DateTime? createdTime,
    DateTime? lastEditedTime,
    // Datebase properties
    required String title,
    // TODO: Add icon & cover
    required this.properties,
    required this.parent,
    required this.url,
  }) : super(
          id: id,
          createdTime: createdTime,
          lastEditedTime: lastEditedTime,
        ) {
    _title.add(RichText(title));
  }

  /// Database constructor with defaults parameters.
  ///
  /// Can receive the database [parent], [title] and the [mainColumnName] but in a simplified way.
  ///
  /// The [title] parameter is a string that will be the content at the only `RichtText` element in the `title` attribute. And the [mainColumnName] is the name of the default title column for the database that is mandatory.
  Database.simple({
    required this.parent,
    required String mainColumnName,
    String? title,
  })  : this.url = '',
        this.properties = DatabaseProperties(mainColumnName: mainColumnName) {
    if (title != null) _title.add(RichText(title));
  }

  /// Map a new database instance from a [json] map.
  factory Database.fromJson(Map<String, dynamic> json) {
    throwIfAnyNull(json, ['id', 'properties', 'parent', 'url']);

    Database database = Database(
      properties: DatabaseProperties.fromJson(json['properties']),
      parent: Parent.fromJson(json['parent']),
    );

    database.id = json['id'];
    database.url = json['url'];
    database._title.addAll(RichText.fromListJson(json['title'] ?? []));

    if (json['last_edited_time'] != null) {
      database.lastEditedTime = DateTime.parse(json['last_edited_time']);
    }

    if (json['created_time'] != null) {
      database.createdTime = DateTime.parse(json['created_time']);
    }

    return database;
  }

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
  void addProperty({required String name, required DatabaseProperty property}) {
    this.properties.add(name: name, property: property);
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toRequestJson() => {
        'parent': parent.toJson(),
        'title': _title.map((richText) => richText.toJson()).toList(),
        'properties': properties.toJson(),
      };

  /// Convert this to a valid json representation for the Notion API response.
  Map<String, dynamic> toJson() => {
        'object': objectTypeToString(this.object),
        'id': this.id,
        'created_time': createdTime,
        'last_edited_by': lastEditedTime,
        'title': _title.map((e) => e.toJson()).toList(),
        'parent': parent.toJson(),
        'properties': properties.toJson(),
      };
}
