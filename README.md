Notion API client for dart.

![CI](https://github.com/jonathangomz/notion_api/actions/workflows/main.yml/badge.svg)
[![codecov](https://codecov.io/gh/jonathangomz/notion_api/branch/main/graph/badge.svg?token=4XYHP1W8ZY)](https://codecov.io/gh/jonathangomz/notion_api)

See the [ROADMAP](ROADMAP.md) file to see what is coming next.

# Usage
**Important**: The methods return a `NotionResponse`. You can find how to use it in its [documentation][1].

## `NotionClient` class
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

## Some examples
_To see more examples [go here](example/example.md)._

### Append blocks children
```dart
// Create children instance:
Children children = Children().addAll([
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

// Send the instance to Notion
notion.blocks.append(
  to: 'YOUR_BLOCK_ID',
  children: children,
);
```

### Create a page
```dart
// Create a page instance
Page page = Page(
  parent: Parent.database(id: 'YOUR_DATABASE_ID'),
  title: Text('NotionClient (v1): Page test'),
);

// Send the instance to Notion.
notion.pages.create(page);
```

# Next release
## v1.0.0:
> Release date: 25/Jun/2021
### Changes
* Fix any error

# Contributions
Please help, I don't even know if what I'm doing is right.

[1]:https://pub.dev/documentation/notion_api/1.0.0-beta1/responses_notion_response/NotionResponse-class.html