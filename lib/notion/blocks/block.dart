import 'package:notion_api/notion/general/base_properties.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

/// A base representation of any Notion block object.
class Block extends BaseProperties {
  /// The type of object. Always Block for this.
  ObjectTypes object = ObjectTypes.Block;

  /// The block id.
  String id = '';

  /// The block type
  BlockTypes type = BlockTypes.None;

  /// The checker for block children.
  bool hasChildren = false;

  /// The json representation for the content of the block.
  Map<String, dynamic> jsonContent = {};

  /// The string value for this block type.
  String get strType => NotionUtils.blockTypeToString(this.type);

  /// The string value for this object type.
  String get strObject => NotionUtils.objectTypeToString(this.object);

  /// Returns true if is a ToDo block.
  bool get isToDo => this.type == BlockTypes.ToDo;

  /// Returns true if is a Paragraph block.
  bool get isParagraph => this.type == BlockTypes.Paragraph;

  /// Returns true if is a Heading block.
  bool get isHeading => NotionUtils.headingsTypes.contains(this.type);

  /// Returns true if is a Toogle block.
  bool get isToogle => this.type == BlockTypes.Toogle;

  /// Returns true if is a Bulleted block.
  bool get isBulleted => this.type == BlockTypes.BulletedList;

  /// Returns true if is a Numbered block.
  bool get isNumbered => this.type == BlockTypes.NumberedList;

  /// Returns true if is a Child block.
  bool get isChild => this.type == BlockTypes.Child;

  /// Returns true if is none block.
  bool get isNone => this.type == BlockTypes.None;

  /// Main block constructor.
  ///
  /// Can receive the [id], if this [hasChildren], the [jsonContent] and the [type] of block.
  /// Possible types are defined by BlockTypes enum.
  ///
  /// Also can receive the [createdTime] and the [lastEditedTime] of the block in case that the information is filled from response.
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

  /// Create a new Block instance from json.
  ///
  /// Receive a [json] from where the information is extracted.
  Block.fromJson(Map<String, dynamic> json)
      : this.id = json['id'] ?? '',
        this.hasChildren = json['has_children'] ?? false,
        this.jsonContent = json['type'] != null ? json[json['type']] ?? {} : {},
        this.type = NotionUtils.stringToBlockType(json['type'] ?? ''),
        super(
          createdTime: json['created_time'] ?? '',
          lastEditedTime: json['last_edited_time'] ?? '',
        );

  /// Convert this to a valid json representation for the Notion API.
  ///
  /// Throw an exception if the block have no type (BlockTypes.None).
  Map<String, dynamic> toJson() {
    if (this.type == BlockTypes.None) {
      throw 'None type for block';
    }

    return {
      'object': strObject,
      'type': strType,
      strType: jsonContent,
    };
  }

  /// Map a list of blocks from a [json] list with dynamics.
  static List<Block> fromListJson(List<dynamic> json) =>
      List<Block>.from(json.map((e) => Block.fromJson(e)).toList());
}
