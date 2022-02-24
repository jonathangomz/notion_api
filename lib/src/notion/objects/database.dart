import '../../utils/utils.dart';
import '../general/exports.dart';
import '../lists/properties.dart';
import '../rich_text.dart';
import 'object.dart';
import 'parent.dart';

/// A representation of the Databse Notion object.
class Database extends Object {
  /// The type of this object. Always Database for this.
  @override
  final ObjectTypes object = ObjectTypes.Database;

  /// The title of this database.
  List<RichText> title = <RichText>[];

  /// The properties of this database.
  Properties properties = Properties();

  /// The information of the page parent.
  Parent parent;

  /// The URL of the Notion datanase.
  String url;

  /// Map a new database instance for a new request.
  Database({
    required this.parent,
    required this.properties,
    this.title: const <RichText>[],
  }) : url = '';

  /// Main database constructor.
  /// TODO: Update docs.
  /// Can receive the [parent] (required), the [title] (empty), the [pagesColumnName] ("Name") and the [properties] (null).
  Database.constructor({
    // Object properties
    required String id,
    DateTime? createdTime,
    DateTime? lastEditedTime,
    // Datebase properties
    required this.title,
    // TODO: Add icon & cover
    required this.properties,
    required this.parent,
    required this.url,
  }) : super(
          id: id,
          createdTime: createdTime,
          lastEditedTime: lastEditedTime,
        );

  /// Constructor for empty database.
  Database.empty()
      : url = "",
        parent = Parent.none();

  /// Database constructor with defaults parameters.
  ///
  /// Can receive the [parent] (none parent), [title] (empty), the [createdTime] (""), the [lastEditedTime] ("") and the database [id] ("") but every parameter is optional.
  Database.withDefaults({
    this.parent: const Parent.none(),
    this.title: const <RichText>[],
    this.url: '',
    String id: '',
    DateTime? createdTime,
    DateTime? lastEditedTime,
  }) : super(
          id: id,
          createdTime: createdTime,
          lastEditedTime: lastEditedTime,
        );

  /// Map a new database instance from a [json] map.
  factory Database.fromJson(Map<String, dynamic> json) {
    throwIfAnyNull(json, ['id', 'properties', 'parent', 'url']);

    return Database.constructor(
      id: json['id'],
      createdTime: json['created_time'] != null
          ? DateTime.parse(json['created_time'])
          : null,
      lastEditedTime: json['last_edited_time'] != null
          ? DateTime.parse(json['last_edited_time'])
          : null,
      title: RichText.fromListJson(json['title'] ?? []),
      properties: Properties.fromJson(json['properties']),
      parent: Parent.fromJson(json['parent']),
      url: json['url'],
    );
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
  Map<String, dynamic> toRequestJson() => {
        'parent': parent.toJson(),
        'title': title.map((richText) => richText.toJson()).toList(),
        'properties': properties.toJson(),
      };

  /// Convert this to a valid json representation for the Notion API response.
  Map<String, dynamic> toJson() => {
        'object': objectTypeToString(this.object),
        'id': this.id,
        'created_time': createdTime,
        'last_edited_by': lastEditedTime,
        'title': title.map((e) => e.toJson()).toList(),
        'parent': parent.toJson(),
        'properties': properties.toJson(),
      };
}
