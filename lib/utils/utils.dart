import 'package:notion_api/notion/general/types/notion_types.dart';

class NotionUtils {
  static List<ObjectsTypes> allObjectTypes = ObjectsTypes.values;
  static List<BlocksTypes> allBlockTypes = BlocksTypes.values;
  static List<PropertiesTypes> allPropertyTypes = PropertiesTypes.values;

  static List<String> allStrPropertyTypes = [
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

  static List<PropertiesTypes> get haveContentList =>
      [PropertiesTypes.Title, PropertiesTypes.MultiSelect];

  static get headingsTypes => [
        BlocksTypes.H1,
        BlocksTypes.H2,
        BlocksTypes.H3,
      ];

  static get textProperty => _allBut([]);

  static get childrenProperty => _allBut(headingsTypes);

  static get checkedProperty => [BlocksTypes.ToDo];

  static get titleProperty => [];

  static bool contentIsList(PropertiesTypes type) =>
      haveContentList.contains(type);

  static List<BlocksTypes> _allBut(List<BlocksTypes> excludedTypes) {
    List<BlocksTypes> copy = [...allBlockTypes];
    copy.removeWhere((element) => excludedTypes.contains(element));
    return copy;
  }

  static String blockTypeToString(BlocksTypes type) {
    switch (type) {
      case BlocksTypes.None:
        return '';
      case BlocksTypes.ToDo:
        return 'to_do';
      case BlocksTypes.H1:
        return 'heading_1';
      case BlocksTypes.H2:
        return 'heading_2';
      case BlocksTypes.H3:
        return 'heading_3';
      case BlocksTypes.Paragraph:
        return 'paragraph';
      case BlocksTypes.BulletedList:
        return 'bulleted_list_item';
      case BlocksTypes.NumberedList:
        return 'numbered_list_item';
      case BlocksTypes.Toogle:
        return 'toggle';
      case BlocksTypes.Child:
        return 'child_page';
      case BlocksTypes.Unsupported:
      default:
        return 'unsupported';
    }
  }

  static BlocksTypes stringToBlockType(String type) {
    switch (type) {
      case '':
        return BlocksTypes.None;
      case 'heading_1':
        return BlocksTypes.H1;
      case 'heading_2':
        return BlocksTypes.H2;
      case 'heading_3':
        return BlocksTypes.H3;
      case 'paragraph':
        return BlocksTypes.Paragraph;
      case 'bulleted_list_item':
        return BlocksTypes.BulletedList;
      case 'numbered_list_item':
        return BlocksTypes.NumberedList;
      case 'toogle':
        return BlocksTypes.Toogle;
      case 'to_do':
        return BlocksTypes.ToDo;
      case 'child_page':
        return BlocksTypes.Child;
      case 'unsupported':
      default:
        return BlocksTypes.Unsupported;
    }
  }

  /// Get the string value of the color type.
  static String colorTypeToString(ColorsTypes color) {
    switch (color) {
      case ColorsTypes.gray:
        return 'gray';
      case ColorsTypes.brown:
        return 'brown';
      case ColorsTypes.orange:
        return 'orange';
      case ColorsTypes.yellow:
        return 'yellow';
      case ColorsTypes.none:
        return 'default';
    }
  }

  /// Get the type color of the string value.
  static ColorsTypes stringToColorType(String color) {
    switch (color) {
      case 'gray':
        return ColorsTypes.gray;
      case 'brown':
        return ColorsTypes.brown;
      case 'orange':
        return ColorsTypes.orange;
      case 'yellow':
        return ColorsTypes.yellow;
      case 'default':
      default:
        return ColorsTypes.none;
    }
  }

  static String objectTypeToString(ObjectsTypes type) {
    switch (type) {
      case ObjectsTypes.Error:
        return 'error';
      case ObjectsTypes.Database:
        return 'database';
      case ObjectsTypes.List:
        return 'list';
      case ObjectsTypes.Page:
        return 'page';
      case ObjectsTypes.Object:
        return 'object';
      case ObjectsTypes.Block:
        return 'block';
      case ObjectsTypes.None:
        return 'none';
    }
  }

  static ObjectsTypes stringToObjectType(String type) {
    switch (type) {
      case 'error':
        return ObjectsTypes.Error;
      case 'database':
        return ObjectsTypes.Database;
      case 'list':
        return ObjectsTypes.List;
      case 'page':
        return ObjectsTypes.Page;
      case 'object':
        return ObjectsTypes.Object;
      case 'block':
        return ObjectsTypes.Block;
      case 'none':
      default:
        return ObjectsTypes.None;
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
      default:
        return PropertiesTypes.None;
    }
  }

  static PropertiesTypes extractPropertyType(Map<String, dynamic> json) {
    if (json.keys.contains('type')) {
      return stringToPropertyType(json['type']);
    } else {
      PropertiesTypes type = PropertiesTypes.None;
      json.keys.forEach((key) {
        if (allStrPropertyTypes.contains(key)) {
          type = stringToPropertyType(key);
        }
      });
      return type;
    }
  }

  static List<String> contentProperties(BlocksTypes type) {
    List<String> properties = [];

    if (textProperty.contains(type)) {
      properties.add('text');
    }
    if (childrenProperty.contains(type)) {
      properties.add('children');
    }
    if (checkedProperty.contains(type)) {
      properties.add('checked');
    }
    if (titleProperty.contains(type)) {
      properties.add('type');
    }

    return properties;
  }

  /// Find if a json [field] is a List
  static bool fieldIsList(dynamic field) => field is List;
}
