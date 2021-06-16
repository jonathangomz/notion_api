import 'package:notion_api/notion/general/types/notion_types.dart';

class NotionTypes {
  final List<ObjectTypes> object = ObjectTypes.values;
  final List<BlockTypes> block = BlockTypes.values;
  final List<PropertiesTypes> properties = PropertiesTypes.values;
  final List<ColorsTypes> colors = ColorsTypes.values;
}

class NotionUtils {
  static NotionTypes types = NotionTypes();

  static List<String> _allStrPropertyTypes = [
    'rich_text',
    'number',
    'select',
    'multi_select',
    'date',
    'people',
    'file',
    'checkbox',
    'url',
    'email',
    'phone_number',
    'formula',
    'relation',
    'rollup',
    'created_time',
    'created_by',
    'last_edited_time',
    'last_edited_by',
    'title'
  ];

  static List<BlockTypes> get headingsTypes => [
        BlockTypes.H1,
        BlockTypes.H2,
        BlockTypes.H3,
      ];

  static String blockTypeToString(BlockTypes type) {
    switch (type) {
      case BlockTypes.Unsupported:
        return 'unsupported';
      case BlockTypes.ToDo:
        return 'to_do';
      case BlockTypes.H1:
        return 'heading_1';
      case BlockTypes.H2:
        return 'heading_2';
      case BlockTypes.H3:
        return 'heading_3';
      case BlockTypes.Paragraph:
        return 'paragraph';
      case BlockTypes.BulletedList:
        return 'bulleted_list_item';
      case BlockTypes.NumberedList:
        return 'numbered_list_item';
      case BlockTypes.Toogle:
        return 'toggle';
      case BlockTypes.Child:
        return 'child_page';
      case BlockTypes.None:
        return '';
    }
  }

  static BlockTypes stringToBlockType(String type) {
    switch (type) {
      case 'heading_1':
        return BlockTypes.H1;
      case 'heading_2':
        return BlockTypes.H2;
      case 'heading_3':
        return BlockTypes.H3;
      case 'paragraph':
        return BlockTypes.Paragraph;
      case 'bulleted_list_item':
        return BlockTypes.BulletedList;
      case 'numbered_list_item':
        return BlockTypes.NumberedList;
      case 'toogle':
        return BlockTypes.Toogle;
      case 'to_do':
        return BlockTypes.ToDo;
      case 'child_page':
        return BlockTypes.Child;
      case 'unsupported':
        return BlockTypes.Unsupported;
      case '':
      default:
        return BlockTypes.None;
    }
  }

  /// Get the string value of the color type.
  static String colorTypeToString(ColorsTypes color) {
    switch (color) {
      case ColorsTypes.Gray:
        return 'gray';
      case ColorsTypes.Brown:
        return 'brown';
      case ColorsTypes.Orange:
        return 'orange';
      case ColorsTypes.Yellow:
        return 'yellow';
      case ColorsTypes.Default:
        return 'default';
    }
  }

  /// Get the type color of the string value.
  static ColorsTypes stringToColorType(String color) {
    switch (color) {
      case 'gray':
        return ColorsTypes.Gray;
      case 'brown':
        return ColorsTypes.Brown;
      case 'orange':
        return ColorsTypes.Orange;
      case 'yellow':
        return ColorsTypes.Yellow;
      case 'default':
      default:
        return ColorsTypes.Default;
    }
  }

  static String objectTypeToString(ObjectTypes type) {
    switch (type) {
      case ObjectTypes.Error:
        return 'error';
      case ObjectTypes.Database:
        return 'database';
      case ObjectTypes.List:
        return 'list';
      case ObjectTypes.Page:
        return 'page';
      case ObjectTypes.Object:
        return 'object';
      case ObjectTypes.Block:
        return 'block';
      case ObjectTypes.None:
        return '';
    }
  }

  static ObjectTypes stringToObjectType(String type) {
    switch (type) {
      case 'error':
        return ObjectTypes.Error;
      case 'database':
        return ObjectTypes.Database;
      case 'list':
        return ObjectTypes.List;
      case 'page':
        return ObjectTypes.Page;
      case 'object':
        return ObjectTypes.Object;
      case 'block':
        return ObjectTypes.Block;
      case '':
      default:
        return ObjectTypes.None;
    }
  }

  static String propertyTypeToString(PropertiesTypes type) {
    switch (type) {
      case PropertiesTypes.RichText:
        return 'rich_text';
      case PropertiesTypes.Number:
        return 'number';
      case PropertiesTypes.Select:
        return 'select';
      case PropertiesTypes.MultiSelect:
        return 'multi_select';
      case PropertiesTypes.Date:
        return 'date';
      case PropertiesTypes.People:
        return 'people';
      case PropertiesTypes.File:
        return 'file';
      case PropertiesTypes.Checkbox:
        return 'checkbox';
      case PropertiesTypes.URL:
        return 'url';
      case PropertiesTypes.Email:
        return 'email';
      case PropertiesTypes.PhoneNumber:
        return 'phone_number';
      case PropertiesTypes.Formula:
        return 'formula';
      case PropertiesTypes.Relation:
        return 'relation';
      case PropertiesTypes.Rollup:
        return 'rollup';
      case PropertiesTypes.CreatedTime:
        return 'created_time';
      case PropertiesTypes.CreatedBy:
        return 'created_by';
      case PropertiesTypes.LastEditedTime:
        return 'last_edited_time';
      case PropertiesTypes.LastEditedBy:
        return 'last_edited_by';
      case PropertiesTypes.Title:
        return 'title';
      case PropertiesTypes.None:
        return '';
    }
  }

  static PropertiesTypes stringToPropertyType(String type) {
    switch (type) {
      case 'rich_text':
        return PropertiesTypes.RichText;
      case 'number':
        return PropertiesTypes.Number;
      case 'select':
        return PropertiesTypes.Select;
      case 'multi_select':
        return PropertiesTypes.MultiSelect;
      case 'date':
        return PropertiesTypes.Date;
      case 'people':
        return PropertiesTypes.People;
      case 'file':
        return PropertiesTypes.File;
      case 'checkbox':
        return PropertiesTypes.Checkbox;
      case 'url':
        return PropertiesTypes.URL;
      case 'email':
        return PropertiesTypes.Email;
      case 'phone_number':
        return PropertiesTypes.PhoneNumber;
      case 'formula':
        return PropertiesTypes.Formula;
      case 'relation':
        return PropertiesTypes.Relation;
      case 'rollup':
        return PropertiesTypes.Rollup;
      case 'created_time':
        return PropertiesTypes.CreatedTime;
      case 'created_by':
        return PropertiesTypes.CreatedBy;
      case 'last_edited_time':
        return PropertiesTypes.LastEditedTime;
      case 'last_edited_by':
        return PropertiesTypes.LastEditedBy;
      case 'title':
        return PropertiesTypes.Title;
      case '':
      default:
        return PropertiesTypes.None;
    }
  }

  static String parentTypeToString(ParentType type) {
    switch (type) {
      case ParentType.Workspace:
        return 'workspace';
      case ParentType.Database:
        return 'database_id';
      case ParentType.Page:
        return 'page_id';
      case ParentType.None:
        return '';
    }
  }

  static ParentType stringToParentType(String type) {
    switch (type) {
      case 'workspace':
        return ParentType.Workspace;
      case 'database_id':
        return ParentType.Database;
      case 'page_id':
        return ParentType.Page;
      case '':
      default:
        return ParentType.None;
    }
  }

  static PropertiesTypes extractPropertyType(Map<String, dynamic> json) {
    if (json.keys.contains('type')) {
      return stringToPropertyType(json['type']);
    } else {
      PropertiesTypes type = PropertiesTypes.None;
      json.keys.forEach((key) {
        if (_allStrPropertyTypes.contains(key)) {
          type = stringToPropertyType(key);
        }
      });
      return type;
    }
  }

  /// Find if a json [field] is a List
  static bool fieldIsList(dynamic field) => field is List;
}
