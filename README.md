Notion API client for dart.

# Using
**Important**: The methods return a `http.Response`. You can find how to use it in its [documentation][1].

## `NotionClient` class
You only have to create a new instance of the `NotionClient` class and all the API requests will be available as class methods.
```dart
NotionClient notion = NotionClient(token: 'YOUR SECRET TOKEN FROM INTEGRATIONS PAGE');
```

### Creating pages
```dart
Page page = Page(databaseId: 'YOUR DATABASE ID');
page.title = Text(content: 'The title of the new page');

notion.pages.create(page);
```

### Retrieving pages
```dart
notion.pages.fetch('YOUR_PAGE_ID');
```
### Retrieving a database
```dart
notion.databases.fetch('YOUR_DATABASE_ID');
```

### Retrieving all databases
> **Warning**: [This endpoint is not recommended][2] by the Notion team.

_Parameters:_
- _startCursor: If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results._
- _pageSize: The number of items from the full list desired in the response. Maximum: 100, otherwise will be ignored._
```dart
notion.databases.fetchAll();
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
[2]: https://developers.notion.com/reference/get-databases