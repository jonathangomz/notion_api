import 'package:notion_api/src/notion/new/properties.dart';
import 'package:notion_api/src/notion/new/property.dart';
import 'package:notion_api/src/utils/utils.dart';
import 'package:notion_api/src/notion/general/notion_types.dart';

class DatabaseProperties extends Properties<DatabaseProperty> {
  /// Main properties constructor.
  ///
  /// Should receive the default [mainColumnName] for the permanent title column. Also can receive a properties [properties].
  DatabaseProperties({
    String? mainColumnName,
    Map<String, DatabaseProperty>? properties,
  }) : super(map: properties) {
    if (mainColumnName != null)
      add(name: mainColumnName, property: DatabaseProperty.Title());
  }

  /// Map a new properties instance from a [json] map.
  DatabaseProperties.fromJson(Map<String, dynamic> json) {
    json.entries.forEach((entry) {
      entries[entry.key] = DatabaseProperty.fromJson(entry.value);
    });
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    entries.entries.forEach((element) {
      json[element.key] = element.value.toJson();
    });

    return json;
  }
}

/// A representation of a single property for any Notion object.
class DatabaseProperty extends Property {
  /// The property name.
  String name;

  /// Main property constructor.
  ///
  /// Can receive the property [id] and [name].
  DatabaseProperty({String? id, String? name})
      : name = name ?? '',
        super(id: id);

  /// Get this as a valid partial json representation for the Notion API.
  Map<String, dynamic> toJson() => {
        'type': strType,
        if (id.isNotEmpty) 'id': id,
        if (name.isNotEmpty) 'name': name,
      };

  /// Create a new Property instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  factory DatabaseProperty.fromJson(Map<String, dynamic> json) {
    PropertiesTypes type = extractPropertyType(json);
    if (type == PropertiesTypes.Title) {
      return TitleDbProp.fromJson(json);
    } else if (type == PropertiesTypes.RichText) {
      return RichTextDbProp.fromJson(json);
    } else if (type == PropertiesTypes.MultiSelect) {
      return MultiSelectDbProp.fromJson(json);
    } else if (type == PropertiesTypes.Checkbox) {
      return CheckboxtDbProp.fromJson(json);
    } else {
      return DatabaseProperty();
    }
  }

  static TitleDbProp Title({
    String? name,
  }) =>
      TitleDbProp(name: name);

  static RichTextDbProp RichText({
    String? name,
  }) =>
      RichTextDbProp(name: name);

  static MultiSelectDbProp MultiSelect({
    List<MultiSelectOptionDbProp> options: const [],
    String? name,
  }) =>
      MultiSelectDbProp(name: name);

  static CheckboxtDbProp Checkbox({
    String? name,
  }) =>
      CheckboxtDbProp(name: name);
}

class TitleDbProp extends DatabaseProperty {
  @override
  final PropertiesTypes type = PropertiesTypes.Title;

  TitleDbProp({String? name}) : super(name: name);

  TitleDbProp.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
        );

  /// Get this as a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'type': strType,
        if (id.isNotEmpty) 'id': id,
        if (name.isNotEmpty) 'name': name,
        strType: {},
      };
}

class RichTextDbProp extends DatabaseProperty {
  @override
  final PropertiesTypes type = PropertiesTypes.RichText;

  RichTextDbProp({String? name}) : super(name: name);

  RichTextDbProp.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
        );

  /// Get this as a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'type': strType,
        if (id.isNotEmpty) 'id': id,
        if (name.isNotEmpty) 'name': name,
        strType: {},
      };
}

class CheckboxtDbProp extends DatabaseProperty {
  @override
  final PropertiesTypes type = PropertiesTypes.Checkbox;

  CheckboxtDbProp({String? name}) : super(name: name);

  CheckboxtDbProp.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          name: json['name'],
        );

  /// Get this as a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'type': strType,
        if (id.isNotEmpty) 'id': id,
        if (name.isNotEmpty) 'name': name,
        strType: {},
      };
}

class MultiSelectDbProp extends DatabaseProperty {
  @override
  PropertiesTypes type = PropertiesTypes.MultiSelect;

  List<MultiSelectOptionDbProp> options;

  MultiSelectDbProp({
    this.options: const [],
    String? name,
  }) : super(name: name);

  MultiSelectDbProp.fromJson(Map<String, dynamic> json)
      : options = List.from(
                json[propertyTypeToString(PropertiesTypes.MultiSelect)]
                    ['options'])
            .map((e) => MultiSelectOptionDbProp.fromJson(e))
            .toList(),
        super(
          id: json['id'],
          name: json['name'],
        );

  /// Get this as a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() => {
        'type': strType,
        if (id.isNotEmpty) 'id': id,
        if (name.isNotEmpty) 'name': name,
        strType: {
          'options':
              options.isNotEmpty ? options.map((e) => e.toJson()).toList() : [],
        },
      };
}

class MultiSelectOptionDbProp {
  /// The option name.
  String name;

  /// The option id.
  String? id;

  /// The option color.
  ColorsTypes color;

  /// Main multi select option property constructor.
  ///
  /// Required the [name] field to display a text for the option. Also can receive the [id] and the [color] of the option.
  MultiSelectOptionDbProp({
    required this.name,
    this.id,
    this.color: ColorsTypes.Default,
  });

  /// Create a new multi select instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  MultiSelectOptionDbProp.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.color = stringToColorType(json['color']);

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'color': colorTypeToString(color),
      };
}
