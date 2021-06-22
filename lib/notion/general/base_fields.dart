import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';

/// A base representation of the base properties of almost any Notion object.
class BaseFields {
  /// The object type.
  ObjectTypes object;

  /// The object id.
  String id;

  /// The creation time of the object.
  String createdTime;

  /// The last edited time of the object.
  String lastEditedTime;

  /// The string value of the object type.
  String get strObject => objectTypeToString(object);

  /// Main base properties constructor.
  ///
  /// Can receive the [object], the [id], the [createdTime] and the [lastEditedTime] of the object.
  ///
  /// **Note:** This class is mainly (if no only) used by extending it.
  BaseFields({
    this.object: ObjectTypes.Object,
    this.id: '',
    this.createdTime: '',
    this.lastEditedTime: '',
  });

  /// Map the properties from a [json] map.
  BaseFields.fromJson(Map<String, dynamic> json)
      : this.object = stringToObjectType(json['object']),
        this.id = json['id'] ?? '',
        this.createdTime = json['created_time'] ?? '',
        this.lastEditedTime = json['last_edited_time'] ?? '';

  /// Set the [createdTime] and the [lastEditedTime] properties.
  ///
  /// This function is used to set the base properties from the constructor of the class in which it is inherited.
  void setBaseProperties({
    required String createdTime,
    required String lastEditedTime,
  }) {
    this.createdTime = createdTime;
    this.lastEditedTime = lastEditedTime;
  }
}
