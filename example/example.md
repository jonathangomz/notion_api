**Content**
- [Initialization](#initialization)
  - [Full instance](#full-instance)
  - [Individual classes](#individual-classes)
- [Pages](#pages)
  - [Create a page](#create-a-page)
  - [Update a page](#update-a-page)
    - [Archive (delete) a page](#archive-delete-a-page)
  - [Retrieve a page](#retrieve-a-page)
- [Databases](#databases)
  - [Create a database](#create-a-database)
  - [Retrieve a database](#retrieve-a-database)
  - [List databases](#list-databases)
- [Block children](#block-children)
  - [Retrieve block children](#retrieve-block-children)
  - [Append block children](#append-block-children)
    - [Heading & Paragraph](#heading--paragraph)
    - [To do](#to-do)
    - [Toggle](#toggle)
    - [Bulleted List Item](#bulleted-list-item)
    - [Numbered List Item](#numbered-list-item)

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
_See more at https://developers.notion.com/reference/post-page_

## Update a page
Update the properties of the page.

If you want to update the content of the page itself the use the block children section.

**Note:** If the parent is a database, the new property values in the properties parameter must conform to the parent database's property schema.
```dart
notion.pages.update('YOUR_PAGE_ID',
  properties: Properties(map: {
    'Description': RichTextProp(content: [
      Text('New value for Description property'),
    ]),
  }),
);
```
_See more at https://developers.notion.com/reference/patch-page_

### Archive (delete) a page
Archive or delete a page is a subaction of update it according to the API reference.

You can archive or un-archive the page just by toggling the boolean value of the `archived` parameter.
```dart
notion.pages.update('YOUR_PAGE_ID',
  archived: true,
);
```
_See more at https://developers.notion.com/reference/patch-page#archive-delete-a-page_

## Retrieve a page
```dart
notion.pages.fetch('YOUR_PAGE_ID');
```
_See more at https://developers.notion.com/reference/get-page_

# Databases
## Create a database
You have to define the parent of the page. It can be:
- `page`
- `workspace`

There is a constructor for each one (_see example below_) but the main constructor can be used as well but the `ParentType` will be required.

**Note:** The `newDatabase` constructor is a temporary solution while the main constructor is deprecating their fields until it became the sustitute for this constructor.
```dart
// With page parent
Page page = Database.newDatabase(
  parent: Parent.page(id: 'YOUR_PAGE_ID'),
  title: [
    Text('Database from examples'),
  ],
  pagesColumnName: 'Custom pages column name',
  properties: Properties(map: {
    'Description': MultiSelectProp(options: [
      MultiSelectOption(name: 'Read', color: ColorsTypes.Blue),
      MultiSelectOption(name: 'Sleep', color: ColorsTypes.Green),
    ]),
  }),
);

notion.databases.create(page);
```
_See more at https://developers.notion.com/reference/create-a-database_

## Retrieve a database
```dart
notion.databases.fetch('YOUR_DATABASE_ID');
```
_See more at https://developers.notion.com/reference/get-database_

## List databases
> **Warning**: [This endpoint is not recommended][1] by the Notion team.

_Parameters:_
- _startCursor: If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results._
- _pageSize: The number of items from the full list desired in the response. Maximum: 100, otherwise will be ignored._
```dart
notion.databases.fetchAll();
```
_See more at https://developers.notion.com/reference/get-databases_

# Block children
## Retrieve block children
```dart
notion.blocks.fetch('YOUR_BLOCK_ID');
```
_See more at https://developers.notion.com/reference/get-block-children_

## Append block children
_Parameters:_
- _to: Identifier for a block._
- _children: Child content to append to a container block as an array of block objects._
  - Can receive a `Paragraph`, `Heading` & `ToDo` object.
  - The `Paragraph` object can contain only `Text` objects.
  - `Text` can receive a `TextAnnotations` class with the style of the text.

### Heading & Paragraph
**Code**
```dart
// Create children instance:
// * Deprecated way
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
    Text(
      'Lorem ipsum (B)',
      annotations: TextAnnotations(
        bold: true,
        underline: true,
        color: ColorsTypes.Orange,
      ),
    ),
  ], children: [
    Heading(text: Text('Subtitle'), type: 3),
  ]),
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
      ),
    ),
  ], children: [
    Heading(text: Text('Subtitle'), type: 3),
  ],
));

// * New way using `withBlocks()` constructor
Children childrenC = Children.withBlocks([
  Heading(text: Text('Test')),
  Paragraph(texts: [
    Text('Lorem ipsum (A)'),
    Text(
      'Lorem ipsum (B)',
      annotations: TextAnnotations(
        bold: true,
        underline: true,
        color: ColorsTypes.Orange,
      ),
    ),
  ], children: [
    Heading(text: Text('Subtitle'), type: 3),
  ]),
]);

// Send the instance to Notion
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: childrenA, // or `childrenB` or `childrenC`, any of these will produce the same result.
);
```

**Result**

![heading&paragraph](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/headingAndParagraph.png)

### To do
**Code**
```dart
// Create children instance:
// * Deprecated way
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
  Children.withBlocks([
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
    ToDo(text: Text('Todo item with children'), children: [
      BulletedListItem(text: Text('A')),
      BulletedListItem(text: Text('B')),
    ]),
  ],
);

// Send the instance to Notion
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: children,
);
```

**Result**

![todo](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/todo.png)

### Toggle
**Code**
```dart
Children children =
  Children.withBlocks([
    Toggle(
      text: Text('This is a toggle block'),
      children: [
        Paragraph(
          texts: [
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas venenatis dolor sed ex egestas, et vehicula tellus faucibus. Sed pellentesque tellus eget imperdiet vulputate.')
          ],
        ),
        BulletedListItem(text: Text('A')),
        BulletedListItem(text: Text('B')),
        BulletedListItem(text: Text('B')),
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

**Result**

![toggle](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/toggle.png)

### Bulleted List Item
**Code**
```dart
Children children =
  Children.withBlocks([
    BulletedListItem(text: Text('This is a bulleted list item A')),
    BulletedListItem(text: Text('This is a bulleted list item B')),
    BulletedListItem(
      text: Text('This is a bulleted list item with children'),
      children: [
        Paragraph(texts: [
          Text('A'),
          Text('B'),
          Text('C'),
        ])
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

**Result**

![bulletedListItem](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/bulletedListItem.png)

### Numbered List Item
**Code**
```dart
Children children =
  Children.withBlocks([
    NumberedListItem(text: Text('This is a numbered list item A')),
    NumberedListItem(text: Text('This is a numbered list item B')),
    NumberedListItem(
      text: Text('This is a bulleted list item with children'),
      children: [
        Paragraph(texts: [
          Text('A'),
          Text('B'),
          Text('C'),
        ])
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

**Result**

![numberedListItem](https://raw.githubusercontent.com/jonathangomz/notion_api/main/example/images/numberedListItem.png)

_See more at https://developers.notion.com/reference/patch-block-children_

[1]: https://developers.notion.com/reference/get-databases