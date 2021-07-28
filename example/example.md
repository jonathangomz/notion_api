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
- [Full example](#full-example)

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

# Full example
Go to see the result https://jonathangomz.notion.site/notion_api-example-0893dd2cb38a413d90165cb810b3c019

```dart
// Initialize the main Notion client
final NotionClient notion = NotionClient(token: 'YOUR_SECRET');

// Create the instance of the page
final Page page = Page(
  parent: Parent.database(id: 'YOUR_DATABASE_ID'),
  title: Text('notion_api example'),
);

// Send the instance to Notion API
var newPage = await notion.pages.create(page);

// Get the new id generated for the created page
String newPageId = newPage.page!.id;

// Create the instance of the content of the page
Children fullContent = Children.withBlocks([
  Heading(text: Text('This the title')),
  Paragraph(texts: [
    Text(
      'Here you can write all the content of the paragraph but if you want to have another style for a single word you will have to do ',
    ),
    Text(
      'this. ',
      annotations: TextAnnotations(
        color: ColorsTypes.Green,
        bold: true,
        italic: true,
      ),
    ),
    Text(
      'Then you can continue writing all your content. See that if you separate the paragraph to stylized some parts you have to take in count the spaces because the ',
    ),
    Text('textSeparator', annotations: TextAnnotations(code: true)),
    Text(
        ' will be deprecated. Maybe you will see this with extra spaces because the separator but soon will be remove.')
  ], children: [
    Heading(
      text: Text('This is a subtitle for the paragraph'),
      type: 2,
    ),
    Paragraph(texts: [
      Text(
        'You can also have children for some blocks like ',
      ),
      ...Text.list(texts: [
        Text.code('Paragraph'),
        Text.code('ToDo'),
        Text.code('BulletedListItems'),
        Text.code('NumberedListItems'),
      ], lastSeparator: ' or '),
      Text('.'),
    ]),
    Paragraph.text(
      'Also, if your paragraph will have the same style you can write all your text directly like this to avoid using a list. This constructor can be found for every block.',
    ),
    Paragraph(
      texts: [
        Text('There are a few shortcuts for basic styles like: '),
        ...Text.list(texts: [
          Text.bold('all text bold and green', color: ColorsTypes.Green),
          Text.code('all text code'),
          Text.italic('all text italic'),
          Text.underline('all text underline'),
        ]),
        Text('.'),
      ],
    ),
  ]),
  Heading(text: Text('Blocks'), type: 2),
  Heading(text: Text('ToDo'), type: 3),
  ToDo(text: Text('Daily meeting'), checked: true),
  ToDo(text: Text('Clean the house')),
  ToDo(text: Text('Do the laundry')),
  ToDo(text: Text('Call mom'), children: [
    Paragraph(texts: [
      Text('Note: ', annotations: TextAnnotations(bold: true)),
      Text('Remember to call her before 20:00'),
    ]),
  ]),
  Heading(text: Text('Lists'), type: 3),
  BulletedListItem(text: Text('Milk')),
  BulletedListItem(text: Text('Cereal')),
  BulletedListItem(text: Text('Eggs')),
  BulletedListItem(text: Text('Tortillas of course')),
  Paragraph(
    text: Text('The numbered list are ordered by default by notion.'),
  ),
  NumberedListItem(text: Text('Notion')),
  NumberedListItem(text: Text('Keep by Google')),
  NumberedListItem(text: Text('Evernote')),
  Heading(text: Text('Toggle'), type: 3),
  Toggle(text: Text('Toogle items'), children: [
    Paragraph(
      text: Text(
        'Toogle items are blocks that can show or hide their children, and their children can be any other block.',
      ),
    ),
  ])
]);

// Append the content to the page
var res = await notion.blocks.append(
  to: newPageId,
  children: fullContent,
);
```