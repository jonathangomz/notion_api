Notion API client for dart.

![CI](https://github.com/jonathangomz/notion_api/actions/workflows/main.yml/badge.svg)
[![codecov](https://codecov.io/gh/jonathangomz/notion_api/branch/main/graph/badge.svg?token=4XYHP1W8ZY)](https://codecov.io/gh/jonathangomz/notion_api)

See the [ROADMAP](ROADMAP.md) file to see what is coming next.

- [Usage](#usage)
  - [`NotionClient` class](#notionclient-class)
  - [Individual classes](#individual-classes)
  - [A few examples](#a-few-examples)
    - [Append blocks children](#append-blocks-children)
    - [Create a page](#create-a-page)
- [Contributions](#contributions)
  - [Rules](#rules)
  - [Tests](#tests)
    - [Example:](#example)
- [Next release](#next-release)
  - [v1.1.0:](#v110)

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

## A few examples
_To see more examples [go here](https://github.com/jonathangomz/notion_api/blob/main/example/example.md)._

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

# Contributions
Please help, I don't even know if what I'm doing is right.

## Rules
Some rules to follow:
1. Please follow the dart convention format:
   1. [Effective dart](https://dart.dev/guides/language/effective-dart)
   2. [`dart format`](https://dart.dev/tools/dart-format)
2. If you are adding a new function, please also add the documentation.
3. If you are adding a new parameters, please also add it to the current documentation.
4. (**Optional**) Run the tests to know that everything is working just fine ([See how run the tests](#tests)).
   * This is optional because sometimes the tests fail on GitHub actions so anyway I will check this on my computer.

## Tests
To be able to run the tests you will have to have a `.env` file on the root directory with the next variables:
* TOKEN: The secret token.
* TEST_DATABASE_ID: The database id where you will be working on.
* TEST_PAGE_ID: Some page id inside the database specified above.
* TEST_BLOCK_ID: Some block id inside the page specified above.

### Example:
_The values are not valid of course._
```
TOKEN=secret_Oa24V8FbJ49JluJankVOQihyLiMXwqSQeeHuSFobQDW
TEST_DATABASE_ID=366da3d646bb458128071fdb2fbbf427
TEST_PAGE_ID=c3b53019-4470-443b-a141-95a3a1a44g60
TEST_BLOCK_ID=c8hac4bb32af48889228bf483d938e34
```

# Next release
## v1.1.0:
> Release date: 10/Jul/2021
* Add more blocks for `(PATCH): block children` endpoint
  * `BulletedList` block
  * `NumberedList` block
  * `Toggle` block
* Add `Children.with(List<Block> blocks)` constructor
* Add singleton (_if possible_)
* Add `final` for override types to not allow change the field:
  * Objects
  * Blocks

[1]:https://pub.dev/documentation/notion_api/1.0.0-beta1/responses_notion_response/NotionResponse-class.html