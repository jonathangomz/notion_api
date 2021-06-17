Notion API client for dart.

# Using
**Important**: The methods return a `NotionResponse`. You can find how to use it in its [documentation][1].

You can see some examples [here](example/example.md).

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

# Contributions
Please help, I don't even know if what I'm doing is right.

[1]:https://pub.dev/documentation/notion_api/1.0.0-beta1/responses_notion_response/NotionResponse-class.html