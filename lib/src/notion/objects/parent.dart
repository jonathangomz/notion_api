import '../../utils/utils.dart';
import '../general/notion_types.dart';

/// A representation of the parent json field for the Notion API.
class Parent {
  /// The type of parent.
  final ParentType type;

  /// The id of the parent.
  final String id;

  /// Main constructor for the page parent.
  ///
  /// This constructor require the parent [id] and the [type] of parent.
  /// Possible types are defined by ParentType enum.
  const Parent({required this.type, required this.id});

  /// Constructor for empty parent.
  const Parent.none()
      : this.type = ParentType.None,
        this.id = '';

  /// Constructor for workspace parent.
  const Parent.workspace()
      : this.type = ParentType.Workspace,
        this.id = '';

  /// Constructor for database parent.
  ///
  /// This constructor require the database [id].
  const Parent.database({required this.id}) : this.type = ParentType.Database;

  /// Constructor for page parent.
  ///
  /// This constructor require the page [id].
  const Parent.page({required this.id}) : this.type = ParentType.Page;

  /// Constructor parent from json.
  ///
  /// This constructor receive a [json] from where the information
  /// is extracted.
  Parent.fromJson(Map<String, dynamic> json)
      : this.id = json[json['type']] ?? '',
        this.type = stringToParentType(json['type'] ?? '');

  /// The string value of this type.
  String get strType => parentTypeToString(this.type);

  /// Convert this to a json representation valid for the Notion API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'type': this.strType};

    // Only database and page types contain an id.
    if (this.type == ParentType.Database || this.type == ParentType.Page) {
      json[strType] = this.id;
    }

    return json;
  }
}
