Notion API client for dart.

## Using
You only have to create a new instance of the NotionClient class and all the API requests will be available as class methods.
> Note: Maybe they will be separated onto separated classes, idk yet.
```dart
NotionClient notion = NotionClient(token: 'YOUR SECRET TOKEN FROM INTEGRATIONS PAGE');
```

### Methods
`20/May/2021`: The methods return a `http.Response`. You can find how to use it in its [documentation][1].

#### Creating pages
```dart
Page page = Page(databaseId: 'YOUR DATABASE ID');
page.title = Text(content: 'The title of the new page');

notion.createPage(page);
```

#### Retrieving pages
```dart
notion.retrievePage(test_page_id);
```

[1]:https://pub.dev/documentation/http/latest/http/Response-class.html