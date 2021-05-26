**Content**
- [Initialization](#initialization)
  - [Full instance](#full-instance)
  - [Individual classes](#individual-classes)
- [Pages](#pages)
  - [Creating pages](#creating-pages)
  - [Retrieving pages](#retrieving-pages)
- [Databases](#databases)
  - [Retrieving a database](#retrieving-a-database)
  - [Retrieving all databases](#retrieving-all-databases)
- [Block children](#block-children)
  - [Retrieving block children](#retrieving-block-children)
  - [Append block children](#append-block-children)

# Initialization
## Full instance
You only have to create a new instance of the `NotionClient` class and all the API requests will be available as class methods.
```dart
NotionClient notion = NotionClient(token: 'YOUR SECRET TOKEN FROM INTEGRATIONS PAGE');
```

## Individual classes
You can also use individual request group class like `NotionPagesClient` or `NotionDatabasesClient`. They are used like the main client but the methods are class methods instead of class properties methods.

**Example**
```dart
// With main class
NotionClient notion = NotionClient(token: 'YOUR_TOKEN');
notion.databases.fetchAll();

// With individual class
NotionDatabasesClient databases = NotionDatabasesClient(token: 'YOUR_TOKEN');
databases.fetchAll();
```

# Pages
## Creating pages
```dart
Page page = Page(
  databaseId: 'YOUR DATABASE ID',
  title: Text(content: 'The title of the new page'),
);

notion.pages.create(page);
```

## Retrieving pages
```dart
notion.pages.fetch('YOUR_PAGE_ID');
```

# Databases
## Retrieving a database
```dart
notion.databases.fetch('YOUR_DATABASE_ID');
```

## Retrieving all databases
> **Warning**: [This endpoint is not recommended][1] by the Notion team.

_Parameters:_
- _startCursor: If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results._
- _pageSize: The number of items from the full list desired in the response. Maximum: 100, otherwise will be ignored._
```dart
notion.databases.fetchAll();
```

# Block children
## Retrieving block children
```dart
notion.blocks.fetch('YOUR_BLOCK_ID');
```

## Append block children
_Parameters:_
- _to: Identifier for a block._
- _children: Child content to append to a container block as an array of block objects._
  - Can receive a `Paragraph` or `Heading` object.
  - The `Paragraph` object can contain only `Text` objects.
  - `Text` can receive a `TextAnnotations` class with the style of the text.
```dart
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: Children(
    heading: Heading('Test'),
    paragraph: Paragraph([
      Text('Lorem ipsum (A)'),
      Text('Lorem ipsum (B)',
         annotations: TextAnnotations(
            bold: true,
            underline: true,
            color: RichTextColors.orange))
    ])));
```

[1]: https://developers.notion.com/reference/get-databases