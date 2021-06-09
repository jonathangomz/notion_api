import 'package:notion_api/notion/general/base_properties.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

class Block extends BaseProperties {
  ObjectsTypes object = ObjectsTypes.Block;
  String id = '';
  BlocksTypes type = BlocksTypes.None;
  bool hasChildren = false;
  Map<String, dynamic> jsonContent = {};

  Block({
    this.id: '',
    this.hasChildren: false,
    this.jsonContent: const {},
    this.type: BlocksTypes.None,
    String createdTime: '',
    String lastEditedTime: '',
  }) {
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        id: json['id'],
        hasChildren: json['has_children'],
        jsonContent: json[json['type']],
        type: NotionUtils.stringToBlockType(json['type']),
        createdTime: json['created_time'],
        lastEditedTime: json['last_edited_time'],
      );

  String get strType => NotionUtils.blockTypeToString(this.type);
  String get strObject => NotionUtils.objectTypeToString(this.object);

  bool get isToDo => this.type == BlocksTypes.ToDo;
  bool get isParagraph => this.type == BlocksTypes.Paragraph;
  bool get isHeading => NotionUtils.headingsTypes.contains(this.type);
  bool get isToogle => this.type == BlocksTypes.Toogle;
  bool get isBulleted => this.type == BlocksTypes.BulletedList;
  bool get isNumbered => this.type == BlocksTypes.NumberedList;
  bool get isChild => this.type == BlocksTypes.Child;
  bool get isNone => this.type == BlocksTypes.None;
}
