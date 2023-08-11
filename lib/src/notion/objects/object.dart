import '../../utils/utils.dart';
import '../general/notion_types.dart';

/// A base representation of the base properties of almost any Notion object.
class Object {
  /// The object type.
  ObjectTypes object;

  /// The object id.
  String id;

  /// The creation time of the object.
  DateTime? createdTime;

  /// The last edited time of the object.
  DateTime? lastEditedTime;

  /// The string value of the object type.
  String get strObject => objectTypeToString(object);

  /// Main base properties constructor.
  ///
  /// Can receive the [object], the [id], the [createdTime] and the [lastEditedTime] of the object.
  ///
  /// **Note:** This class is mainly (if no only) used by extending it.
  Object({
    this.object = ObjectTypes.Object,
    this.id = '',
    DateTime? this.createdTime,
    DateTime? this.lastEditedTime,
  });

  /// Map the properties from a [json] map.
  Object.fromJson(Map<String, dynamic> json)
      : this.object = stringToObjectType(json['object']),
        this.id = json['id'] ?? '',
        this.createdTime = json['created_time'] != null
            ? DateTime.parse(json['created_time'])
            : null,
        this.lastEditedTime = json['last_edited_time'] != null
            ? DateTime.parse(json['last_edited_time'])
            : null;

  /// Set the [createdTime] and the [lastEditedTime] properties.
  ///
  /// This function is used to set the base properties from the constructor of the class in which it is inherited.
  void setBaseProperties({
    DateTime? createdTime,
    DateTime? lastEditedTime,
  }) {
    this.createdTime = createdTime;
    this.lastEditedTime = lastEditedTime;
  }
}
