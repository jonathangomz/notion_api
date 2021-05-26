Notion API client for dart.

# Using
**Important**: The methods return a `http.Response`. You can find how to use it in its [documentation][1].

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

[1]:https://pub.dev/documentation/http/latest/http/Response-class.html