import '../../utils/utils.dart';
import '../general/notion_types.dart';
import 'object.dart';

/// A base representation of any Notion block object.
class Block extends Object {
  /// The type of object. Always Block for this.
  @override
  final ObjectTypes object = ObjectTypes.Block;

  /// The block id.
  String id = '';

  /// The block type
  BlockTypes type = BlockTypes.None;

  /// The checker for block children.
  bool hasChildren = false;

  /// The json representation for the content of the block.
  Map<String, dynamic> jsonContent = {};

  /// The string value for this block type.
  String get strType => blockTypeToString(this.type);

  /// The string value for this object type.
  String get strObject => objectTypeToString(this.object);

  /// Returns true if is a ToDo block.
  bool get isToDo => this.type == BlockTypes.ToDo;

  /// Returns true if is a Paragraph block.
  bool get isParagraph => this.type == BlockTypes.Paragraph;

  /// Returns true if is a Heading block.
  bool get isHeading => headingsTypes.contains(this.type);

  /// Returns true if is a Toogle block.
  bool get isToogle => this.type == BlockTypes.Toggle;

  /// Returns true if is a Bulleted block.
  bool get isBulletedItem => this.type == BlockTypes.BulletedListItem;

  /// Returns true if is a Numbered block.
  bool get isNumberedItem => this.type == BlockTypes.NumberedListItem;

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
    this.id = '',
    this.hasChildren = false,
    this.jsonContent = const {},
    this.type = BlockTypes.None,
    DateTime? createdTime,
    DateTime? lastEditedTime,
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
        this.type = stringToBlockType(json['type'] ?? ''),
        super(
          createdTime: json['created_time'] != null
              ? DateTime.parse(json['created_time'])
              : null,
          lastEditedTime: json['last_edited_time'] != null
              ? DateTime.parse(json['last_edited_time'])
              : null,
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
