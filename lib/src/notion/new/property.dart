import 'package:notion_api/notion_api.dart';

/// A representation of a single property for any Notion object.
class Property {
  /// The property type.
  final PropertiesTypes type = PropertiesTypes.None;

  /// The property id.
  String id;

  /// The string value for this property type.
  String get strType => propertyTypeToString(type);

  /// Main property constructor.
  ///
  /// Can receive the property [id] and [name].
  Property({String? id}) : id = id ?? '';
}
