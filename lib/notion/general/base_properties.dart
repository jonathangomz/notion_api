import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

class BaseProperties {
  ObjectsTypes object;
  String id;
  String createdTime;
  String lastEditedTime;

  BaseProperties({
    this.object: ObjectsTypes.Object,
    this.id: '',
    this.createdTime: '',
    this.lastEditedTime: '',
  });

  String get strObject => NotionUtils.objectTypeToString(object);

  factory BaseProperties.fromJson(Map<String, dynamic> json) => BaseProperties(
      object: json['object'],
      createdTime: json['created_time'],
      lastEditedTime: json['last_edited_time']);

  setBaseProperties({
    required String createdTime,
    required String lastEditedTime,
  }) {
    this.createdTime = createdTime;
    this.lastEditedTime = lastEditedTime;
  }
}
