import 'package:notion_api/notion/general/base_properties.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

class Block extends BaseProperties {
  ObjectTypes object = ObjectTypes.Block;
  String id = '';
  BlockTypes type = BlockTypes.None;
  bool hasChildren = false;
  Map<String, dynamic> jsonContent = {};

  Block({
    this.id: '',
    this.hasChildren: false,
    this.jsonContent: const {},
    this.type: BlockTypes.None,
    String createdTime: '',
    String lastEditedTime: '',
  }) {
    this.setBaseProperties(
      createdTime: createdTime,
      lastEditedTime: lastEditedTime,
    );
  }

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        id: json['id'] ?? '',
        hasChildren: json['has_children'] ?? false,
        jsonContent: json['type'] != null ? json[json['type']] ?? {} : {},
        type: NotionUtils.stringToBlockType(json['type'] ?? ''),
        createdTime: json['created_time'] ?? '',
        lastEditedTime: json['last_edited_time'] ?? '',
      );

  static List<Block> fromListJson(List<dynamic> json) =>
      List<Block>.from(json.map((e) => Block.fromJson(e)).toList());

  String get strType => NotionUtils.blockTypeToString(this.type);
  String get strObject => NotionUtils.objectTypeToString(this.object);

  bool get isToDo => this.type == BlockTypes.ToDo;
  bool get isParagraph => this.type == BlockTypes.Paragraph;
  bool get isHeading => NotionUtils.headingsTypes.contains(this.type);
  bool get isToogle => this.type == BlockTypes.Toogle;
  bool get isBulleted => this.type == BlockTypes.BulletedList;
  bool get isNumbered => this.type == BlockTypes.NumberedList;
  bool get isChild => this.type == BlockTypes.Child;
  bool get isNone => this.type == BlockTypes.None;

  Map<String, dynamic> toJson() => {
        'object': strObject,
        'type': strType,
        strType: jsonContent,
      };
}
