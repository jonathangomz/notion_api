import 'package:notion_api/notion/general/base_properties.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/utils/utils.dart';

class Database extends BaseProperties {
  ObjectTypes object = ObjectTypes.Database;

  List<Text> title = <Text>[];
  Properties properties = Properties();

  Database({
    this.title: const <Text>[],
    String createdTime: '',
    String lastEditedTime: '',
  }) {
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  factory Database.fromJson(Map<String, dynamic> json) => Database(
        title: Text.fromListJson(json['title']),
        createdTime: json['created_time'],
        lastEditedTime: json['last_edited_time'],
      ).addPropertiesFromJson(json['properties']);

  Database addProperty({required String name, required Property property}) {
    this.properties.addProperty(name: name, property: property);
    return this;
  }

  Database addPropertiesFromJson(Map<String, dynamic> json) {
    this.properties.addPropertiesFromJson(json);
    return this;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'object': NotionUtils.objectTypeToString(this.object),
      'title': title.map((e) => e.toJson()).toList(),
      'properties': properties.toJson(),
    };

    return json;
  }
}
