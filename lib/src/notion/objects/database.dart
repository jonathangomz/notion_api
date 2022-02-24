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
  ///
  /// Receive the database [parent] and [properties], and also con receive the database [title] but is optional (by default will set to "Untitled").
  ///
  /// We recommend to use `Properties.forDatabase` on the [properties] field to be sure that any required property is missing, like the Title property.
  Database({
    required this.parent,
    required this.properties,
    this.title: const <RichText>[],
  }) : url = '';

  /// Main database constructor.
  ///
  /// Can receive all the available properties for a database which are the [id], [createdTime], [lastEditedTime], [title], [properties], [parent] and [url].
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

  /// Database constructor with defaults parameters.
  ///
  /// Can receive the database [parent], [title] and the [titleColumnName] but in a simplified way.
  ///
  /// The [title] parameter is a string that will be the content at the only `RichtText` element in the `title` attribute. And the [titleColumnName] is the name of the default title column for the database that is mandatory.
  Database.simple({
    required this.parent,
    required String titleColumnName,
    String? title,
  })  : this.title = <RichText>[if (title != null) RichText(title)],
        this.properties = Properties(map: {
          titleColumnName: DatabaseProperties.Title(),
        }),
        this.url = '';

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
