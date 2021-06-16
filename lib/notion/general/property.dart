import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

/// A representation of the properties for any Notion object.
class Properties {
  final Map<String, Property> _map = {};

  /// The properties map
  Map<String, Property> get entries => _map;

  /// Returns true if the properties map IS empty
  bool get isEmpty => this._map.isEmpty;

  /// Main properties constructor.
  ///
  /// Can receive a properties [map].
  Properties({Map<String, Property> map: const {}}) {
    this._map.addAll(map);
  }

  /// Constructor for an empty instance.
  Properties.empty();

  /// Map a new properties instance from a [json] map.
  Properties.fromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    this._map.addAll(properties);
  }

  /// Add a new [property] with a specific [name].
  void add({required String name, required Property property}) =>
      this._map[name] = property;

  /// Add a group of properties in a [json] map.
  void addAllFromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    this._map.addAll(properties);
  }

  /// Remove the property with the specific [name] and return the deleted property. If not found return an empty instance.
  Property remove(String name) => this._map.remove(name) ?? Property.empty();

  /// Get the property with the specific [name]. If not found return an empty instance.
  Property getProperty(String name) => this._map[name] ?? Property.empty();

  /// Returns true if the property with the specific [name] is contained.
  bool containsProperty(String name) => this._map.containsKey(name);

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    this._map.entries.forEach((element) {
      json[element.key] = element.value.toJson();
    });

    return json;
  }
}

/// A representation of a single property for any Notion object.
class Property {
  /// The property type.
  final PropertiesTypes type = PropertiesTypes.None;

  /// The property id.
  String? id;

  /// The base getter for the content of any property.
  dynamic get value => false;

  /// The string value for this property type.
  String get strType => NotionUtils.propertyTypeToString(type);

  /// Returns true if property is Title type.
  bool get isTitle => type == PropertiesTypes.Title;

  /// Returns true if property is RichText type.
  bool get isRichText => type == PropertiesTypes.RichText;

  /// Returns true if property is MultiSelect type.
  bool get isMultiSelect => type == PropertiesTypes.MultiSelect;

  /// Main property constructor.
  ///
  /// Can receive the property [id].
  Property({this.id});

  /// Constructor for empty property.
  Property.empty();

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() {
    if (type == PropertiesTypes.None) {
      throw 'None type for property';
    }

    Map<String, dynamic> json = {'type': strType};

    if (id != null) {
      json['id'] = id;
    }

    return json;
  }

  /// Map a list of properties from a [json] map.
  static Map<String, Property> propertiesFromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    return properties;
  }

  /// Create a new Property instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  static Property propertyFromJson(Map<String, dynamic> json) {
    PropertiesTypes type = NotionUtils.extractPropertyType(json);
    if (type == PropertiesTypes.Title) {
      bool contentIsList = TitleProp.contentIsList(json);
      return TitleProp.fromJson(json, subfield: contentIsList ? null : 'title');
    } else if (type == PropertiesTypes.RichText) {
      return RichTextProp.fromJson(json);
    } else if (type == PropertiesTypes.MultiSelect) {
      bool contentIsList = MultiSelectProp.contentIsList(json);
      MultiSelectProp multi = MultiSelectProp.fromJson(json,
          subfield: contentIsList ? null : 'options');
      return multi;
    } else {
      return Property();
    }
  }
}

/// A representation of a title property for any Notion object.
class TitleProp extends Property {
  /// The property type. Always Title for this.
  final PropertiesTypes type = PropertiesTypes.Title;

  /// The property content.
  List<Text> content;

  /// Main title property constructor.
  ///
  /// Can receive a list ot texts as the title [content].
  TitleProp({this.content: const <Text>[]});

  /// Create a new property instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  TitleProp.fromJson(Map<String, dynamic> json,
      {String? subfield, bool isEmpty: false})
      : this.content = Text.fromListJson(isEmpty
                ? []
                : ((subfield != null
                        ? json[NotionUtils.propertyTypeToString(
                            PropertiesTypes.Title)][subfield]
                        : json[NotionUtils.propertyTypeToString(
                            PropertiesTypes.Title)]) ??
                    []) as List)
            .toList(),
        super(id: json['id']);

  /// Check if the specific json have a content list.
  static bool contentIsList(Map<String, dynamic> json) =>
      NotionUtils.fieldIsList(
          json[NotionUtils.propertyTypeToString(PropertiesTypes.Title)]);

  /// Returns true if the properties are empty.
  static bool isEmpty(Map<String, dynamic> json) =>
      json[PropertiesTypes.Title]?.isEmpty;

  /// The value of the content.
  @override
  List<Text> get value => this.content;

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': strType};

    if (id != null) {
      json['id'] = id;
    }

    json[strType] = content.map((e) => e.toJson()).toList();

    return json;
  }
}

/// A representation of a rich text property for any Notion object.
class RichTextProp extends Property {
  /// The property type. Always RichText for this.
  final PropertiesTypes type = PropertiesTypes.RichText;

  /// The list of rich text.
  List<Text> content;

  @override
  List<Text> get value => this.content;

  /// Main RichText constructor.
  ///
  /// Can receive the [content] as a list of texts.
  RichTextProp({this.content: const <Text>[]});

  /// Create a new rich text instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  RichTextProp.fromJson(Map<String, dynamic> json)
      : this.content = Text.fromListJson(
            json[NotionUtils.propertyTypeToString(PropertiesTypes.RichText)]
                as List),
        super(id: json['id']);

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': strType};

    if (id != null) {
      json['id'] = id;
    }

    json[strType] = content.map((e) => e.toJson()).toList();

    return json;
  }
}

/// A representation of the multi select Notion object.
class MultiSelectProp extends Property {
  /// The property type. Always MultiSelect for this.
  final PropertiesTypes type = PropertiesTypes.MultiSelect;

  /// The options of the multi select.
  List<MultiSelectOption> options;

  /// Main multi select constructor.
  ///
  /// Can receive the list6 of the options.
  MultiSelectProp({this.options: const <MultiSelectOption>[]});

  MultiSelectProp.fromJson(Map<String, dynamic> json, {String? subfield})
      : this.options = MultiSelectOption.fromListJson((subfield != null
            ? json[NotionUtils.propertyTypeToString(
                PropertiesTypes.MultiSelect)][subfield]
            : json[NotionUtils.propertyTypeToString(
                PropertiesTypes.MultiSelect)]) as List),
        super(id: json['id']);

  /// Add a new [option] to the multi select options and returns this instance.
  List<MultiSelectOption> addOption(MultiSelectOption option) {
    this.options.add(option);
    return this.options;
  }

  /// Convert this to a valid json representation for the Notion API.
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': strType};

    if (id != null) {
      json['id'] = id;
    }

    json[strType] = {'options': options.map((e) => e.toJson()).toList()};

    return json;
  }

  /// Returns true if a json field is a list.
  static bool contentIsList(Map<String, dynamic> json) =>
      NotionUtils.fieldIsList(
          json[NotionUtils.propertyTypeToString(PropertiesTypes.MultiSelect)]);
}

/// A representation of a multi select option property for any Notion object.
class MultiSelectOption {
  /// The option name.
  String name;

  /// The option id.
  String? id;

  /// The option color.
  ColorsTypes color;

  /// Main multi select option property constructor.
  ///
  /// Required the [name] field to display a text for the option. Also can receive the [id] and the [color] of the option.
  MultiSelectOption(
      {required this.name, this.id, this.color: ColorsTypes.Default});

  /// Create a new multi select instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  MultiSelectOption.fromJson(Map<String, dynamic> json)
      : this.name = json['name'] ?? '',
        this.id = json['id'],
        this.color = NotionUtils.stringToColorType(json['color'] ?? '');

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name': name,
      'color': NotionUtils.colorTypeToString(color),
    };

    if (id != null) {
      json['id'] = id;
    }

    return json;
  }

  /// Map a list of options from a [json] list with dynamics.
  static List<MultiSelectOption> fromListJson(List<dynamic> options) =>
      options.map((e) => MultiSelectOption.fromJson(e)).toList();
}
