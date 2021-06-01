/// The basic notion types.
enum NotionTypes {
  H1,
  H2,
  H3,
  Paragraph,
  ToDo,
}

String strType(NotionTypes type) {
  switch (type) {
    case NotionTypes.ToDo:
      return 'to_do';
    case NotionTypes.H1:
      return 'heading_1';
    case NotionTypes.H2:
      return 'heading_2';
    case NotionTypes.H3:
      return 'heading_3';
    case NotionTypes.Paragraph:
      return 'paragraph';
  }
}
