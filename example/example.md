**Content**
- [Initialization](#initialization)
  - [Full instance](#full-instance)
  - [Individual classes](#individual-classes)
- [Pages](#pages)
  - [Create a page](#create-a-page)
  - [Retrieve a page](#retrieve-a-page)
- [Databases](#databases)
  - [Retrieve a database](#retrieve-a-database)
  - [List databases](#list-databases)
- [Block children](#block-children)
  - [Retrieve block children](#retrieve-block-children)
  - [Append block children](#append-block-children)
    - [Example](#example)
      - [Heading & Paragraph](#heading--paragraph)
        - [Code](#code)
        - [Result](#result)
      - [To do](#to-do)
        - [Code](#code-1)
        - [Result](#result-1)

# Initialization
## Full instance
You only have to create a new instance of the `NotionClient` class and all the API requests will be available as class properties methods.
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
## Create a page
You have to define the parent of the page. It can be:
- `database`
- `page`
- `workspace`

There is a constructor for each one (_see example below_) but the main constructor can be used as well but the `ParentType` will be required.
```dart
// With database parent
Page page = Page(
  parent: Parent.database(id: 'YOUR_DATABASE_ID'), // <- database
  title: Text('NotionClient (v1): Page test'),
);

// With page parent
Page page = Page(
  parent: Parent.page(id: 'YOUR_PAGE_ID'), // <- page
  title: Text('NotionClient (v1): Page test'),
);

notion.pages.create(page);
```

## Retrieve a page
```dart
notion.pages.fetch('YOUR_PAGE_ID');
```

# Databases
## Retrieve a database
```dart
notion.databases.fetch('YOUR_DATABASE_ID');
```

## List databases
> **Warning**: [This endpoint is not recommended][1] by the Notion team.

_Parameters:_
- _startCursor: If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results._
- _pageSize: The number of items from the full list desired in the response. Maximum: 100, otherwise will be ignored._
```dart
notion.databases.fetchAll();
```

# Block children
## Retrieve block children
```dart
notion.blocks.fetch('YOUR_BLOCK_ID');
```

## Append block children
_Parameters:_
- _to: Identifier for a block._
- _children: Child content to append to a container block as an array of block objects._
  - Can receive a `Paragraph`, `Heading` & `ToDo` object.
  - The `Paragraph` object can contain only `Text` objects.
  - `Text` can receive a `TextAnnotations` class with the style of the text.

### Example
#### Heading & Paragraph
##### Code
```dart
// Create children instance:
// * Old way
// Children oldWay = Children(
//  heading: Heading('Test'),
//  paragraph: Paragraph(
//   content: [
//      Text('Lorem ipsum (A)'),
//      Text(
//        'Lorem ipsum (B)',
//        annotations: TextAnnotations(
//          bold: true,
//          underline: true,
//          color: ColorsTypes.orange,
//        ),
//      ),
//    ],
//  ),
//);
//
// * New way using `addAll()`
Children childrenA = Children().addAll([
  Heading(text: Text('Test')),
  Paragraph(texts: [
    Text('Lorem ipsum (A)'),
    Text('Lorem ipsum (B)',
        annotations: TextAnnotations(
          bold: true,
          underline: true,
          color: ColorsTypes.Orange,
        ))
  ])
]);

// * New way using single `add()`
Children childrenB =
  Children().add(Heading(text: Text('Test'))).add(Paragraph(texts: [
    Text('Lorem ipsum (A)'),
    Text('Lorem ipsum (B)',
        annotations: TextAnnotations(
          bold: true,
          underline: true,
          color: ColorsTypes.Orange,
        ))
  ]));

// Send the instance to Notion
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: childrenB, // or `childrenA`, both are the same.
);
```

##### Result
![heading&paragraph](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/heading_paragraph.png)

#### To do
##### Code
```dart
// Create children instance:
// * Old way
// Children children = 
//   Children(
//     toDo: [
//       ToDo(text: Text('This is a todo item A')),
//       ToDo(
//         texts: [
//           Text('This is a todo item'),
//           Text(
//             'B',
//             annotations: TextAnnotations(bold: true),
//           ),
//         ],
//       ),
//     ],
//   );
//
// * New way
Children children =
  Children().addAll([
    ToDo(text: Text('This is a todo item A')),
    ToDo(
      texts: [
        Text('This is a todo item'),
        Text(
          'B',
          annotations: TextAnnotations(bold: true),
        ),
      ],
    ),
  ],
);

// Send the instance to Notion
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: children,
);
```

##### Result
![todo](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/todo.png)

[1]: https://developers.notion.com/reference/get-databases