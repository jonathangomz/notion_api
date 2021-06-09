import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

class Properties {
  final Map<String, Property> _map = {};

  get entries => _map;

  Properties({Map<String, Property> map: const {}}) {
    this._map.addAll(map);
  }
  Properties.empty();

  Properties.fromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    this._map.addAll(properties);
  }

  void addProperty({required String name, required Property property}) =>
      this._map[name] = property;

  Property getProperty(String name) => this._map[name] ?? Property.empty();

  bool containsProperty(String name) => this._map.containsKey(name);

  isEmpty() => this._map.isEmpty;

  void addPropertiesFromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    this._map.addAll(properties);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (this._map.isNotEmpty) {
      this._map.entries.forEach((element) {
        json[element.key] = element.value.toJson();
      });
    }

    return json;
  }
}

class Property {
  final PropertiesTypes type = PropertiesTypes.None;
  String? id;

  String get strType => NotionUtils.propertyTypeToString(type);
  bool get isTitle => type == PropertiesTypes.Title;
  bool get isRichText => type == PropertiesTypes.RichText;
  bool get isMultiSelect => type == PropertiesTypes.MultiSelect;

  Property({this.id});
  Property.empty();

  static Map<String, Property> propertiesFromJson(Map<String, dynamic> json) {
    Map<String, Property> properties = {};
    json.entries.forEach((entry) {
      properties[entry.key] = Property.propertyFromJson(entry.value);
    });
    return properties;
  }

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
}

class TitleProp extends Property {
  final PropertiesTypes type = PropertiesTypes.Title;

  List<Text> content;

  TitleProp({this.content: const <Text>[]});

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

  static bool contentIsList(Map<String, dynamic> json) =>
      NotionUtils.fieldIsList(json[PropertiesTypes.Title]);

  static bool isEmpty(Map<String, dynamic> json) =>
      json[PropertiesTypes.Title]?.isEmpty;

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

class RichTextProp extends Property {
  final PropertiesTypes type = PropertiesTypes.RichText;

  List<Text> content;

  RichTextProp({this.content: const <Text>[]});

  RichTextProp.fromJson(Map<String, dynamic> json)
      : this.content = Text.fromListJson(
            json[NotionUtils.propertyTypeToString(PropertiesTypes.RichText)]
                as List),
        super(id: json['id']);

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

class MultiSelectProp extends Property {
  final PropertiesTypes type = PropertiesTypes.MultiSelect;

  List<MultiSelectOption> options;

  MultiSelectProp({this.options: const <MultiSelectOption>[]});

  MultiSelectProp.fromJson(Map<String, dynamic> json, {String? subfield})
      : this.options = MultiSelectOption.fromListJson((subfield != null
            ? json[NotionUtils.propertyTypeToString(
                PropertiesTypes.MultiSelect)][subfield]
            : json[NotionUtils.propertyTypeToString(
                PropertiesTypes.MultiSelect)]) as List),
        super(id: json['id']);

  static bool contentIsList(Map<String, dynamic> json) =>
      NotionUtils.fieldIsList(
          json[NotionUtils.propertyTypeToString(PropertiesTypes.MultiSelect)]);

  List<MultiSelectOption> addOption(MultiSelectOption option) {
    this.options.add(option);
    return this.options;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': strType};

    if (id != null) {
      json['id'] = id;
    }

    json[strType] = {'options': options.map((e) => e.toJson()).toList()};

    return json;
  }
}

class MultiSelectOption {
  String name;
  String? id;
  ColorsTypes color;

  MultiSelectOption(
      {required this.name, this.id, this.color: ColorsTypes.none});

  MultiSelectOption.fromJson(Map<String, dynamic> json)
      : this.name = json['name'] ?? '',
        this.id = json['id'],
        this.color = NotionUtils.stringToColorType(json['color'] ?? '');

  static List<MultiSelectOption> fromListJson(List<dynamic> options) {
    return options.map((e) => MultiSelectOption.fromJson(e)).toList();
  }

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
}
