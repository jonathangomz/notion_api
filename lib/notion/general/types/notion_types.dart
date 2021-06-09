/// The basic notion types.
enum BlockTypes {
  None,
  H1,
  H2,
  H3,
  Paragraph,
  BulletedList,
  NumberedList,
  ToDo,
  Toogle,
  Child,
  Unsupported,
}

enum ObjectTypes {
  None,
  Database,
  Block,
  Object,
  Page,
  List,
  Error,
}

enum PropertiesTypes {
  None,
  Title,
  RichText,
  Number,
  Select,
  MultiSelect,
  Date,
  People,
  File,
  Checkbox,
  URL,
  Email,
  PhoneNumber,
  Formula,
  Relation,
  Rollup,
  CreatedTime,
  CreatedBy,
  LastEditedTime,
  LastEditedBy,
}

/// The basic colors.
enum ColorsTypes {
  Gray,
  Brown,
  Orange,
  Yellow,
  Default,
}
