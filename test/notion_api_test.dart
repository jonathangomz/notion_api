import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/notion_api.dart';
import 'package:notion_api/src/notion/new/database/database_property.dart';
import 'package:test/test.dart';

void main() {
  String? token = Platform.environment['TOKEN'];
  String? testDatabaseId = Platform.environment['TEST_DATABASE_ID'];
  String? testPageId = Platform.environment['TEST_PAGE_ID'];
  String? testBlockId = Platform.environment['TEST_BLOCK_ID'];

  String execEnv = env['EXEC_ENV'] ?? Platform.environment['EXEC_ENV'] ?? '';
  if (execEnv != 'github_actions') {
    setUpAll(() {
      load();

      token = env['TOKEN'] ?? token ?? '';
      testDatabaseId = env['TEST_DATABASE_ID'] ?? testDatabaseId ?? '';
      testPageId = env['TEST_PAGE_ID'] ?? testPageId ?? '';
      testBlockId = env['TEST_BLOCK_ID'] ?? testBlockId ?? '';
    });

    tearDownAll(() {
      clean();
    });
  }

  group('Notion Client', () {
    test('Retrieve a page', () async {
      final Client notion = Client(auth: token ?? '');
      NotionResponse res =
          await notion.pages.retrieve(page_id: testPageId ?? '');

      expect(res.status, 200);
      expect(res.isPage, true);
      expect(res.content, isNotNull);
      expect(res.content, isA<Page>());
      expect(res.isOk, true);
    });
  });

  group('Notion Pages Client =>', () {
    test('Retrieve a page content', () async {
      final Client notion = Client(auth: token ?? '');
      NotionResponse res =
          await notion.pages.retrieve(page_id: testPageId ?? '');

      expect(res.status, 200);
      expect(res.isPage, true);
      expect(res.content, isNotNull);
      expect(res.content, isA<Page>());
      expect(res.isOk, true);
    });

    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(auth: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
        title: Text('NotionClient (v1): Page test'),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(auth: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Create a page with full example', () async {
      Children fullContent = Children(
        blocks: [
          Heading(text: Text('Examples')),
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
              'Then you can continue writing all your content. See that if you separate the paragraph to stylized some parts you have to take in count the spaces.',
            ),
          ], children: [
            Heading.text('Children subtitle', type: 2),
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
              'Also, if your paragraph will have the same style you can write all your text directly like this to avoid using a list.',
            ),
            Paragraph(
              texts: [
                Text('You can use styles for texts like: '),
                ...Text.list(texts: [
                  Text.color('green text', color: ColorsTypes.Green),
                  Text.color('blue text', color: ColorsTypes.Blue),
                  Text.color('red text', color: ColorsTypes.Red),
                  Text.color('purple text', color: ColorsTypes.Purple),
                  Text.underline('underline text'),
                  Text.code('code format text'),
                  Text.italic('italic text'),
                  Text('strikethrough text',
                      annotations: TextAnnotations(strikethrough: true)),
                  Text(
                    'mix styles',
                    annotations: TextAnnotations(
                      bold: true,
                      italic: true,
                      underline: true,
                      color: ColorsTypes.Orange,
                    ),
                  ),
                ], lastSeparator: ' or '),
                Text('!')
              ],
            ),
          ]),
          Heading.text('Blocks', type: 2),
          Heading.text('ToDo', type: 3),
          ToDo.text('Daily meeting', checked: true),
          ToDo.text('Clean the house'),
          ToDo.text('Do the laundry'),
          ToDo.text('Call mom', children: [
            Paragraph(texts: [
              Text.bold('Note: '),
              Text('Remember to call her before 20:00'),
            ]),
          ]),
          Heading.text('Lists', type: 3),
          BulletedListItem.text('Milk'),
          BulletedListItem.text('Cereal'),
          BulletedListItem.text('Eggs'),
          BulletedListItem.text('Tortillas of course'),
          Paragraph.text('The numbered list are ordered by default by notion.'),
          NumberedListItem.text('Notion'),
          NumberedListItem.text('Keep by Google'),
          NumberedListItem.text('Evernote'),
          Heading.text('Toggle', type: 3),
          Toggle.text(
            'Toogle items',
            children: [
              Paragraph.text(
                'Toogle items are blocks that can show or hide their children, and their children can be any other block.',
              ),
            ],
          ),
        ],
      );

      final Client notion = Client(auth: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
        title: Text('notion_api example'),
      );

      var newPage = await notion.pages.create(page);

      String newPageId = newPage.page!.id;

      var res = await notion.blocks.append(
        block_id: newPageId,
        children: fullContent,
      );

      expect(res.status, 200);
    });

    test('Update a page (properties)', () async {
      final NotionPagesClient pages = NotionPagesClient(auth: token ?? '');

      var res = await pages.update(
          page_id: '15db928d5d2a43ada59e3136663d41f6',
          properties: Properties(map: {
            'Property': RichTextProp(content: [Text('A')])
          }));

      expect(res.status, 200);
    });

    test('Update a page (archived)', () async {
      final NotionPagesClient pages = NotionPagesClient(auth: token ?? '');

      var res = await pages.update(
          page_id: '15db928d5d2a43ada59e3136663d41f6', archived: false);

      expect(res.status, 200);
    });
  });

  group('Notion Databases Client =>', () {
    group('Retrieve', () {
      test('Retrieve a database', () async {
        final NotionDatabasesClient databases =
            NotionDatabasesClient(auth: token ?? '');

        NotionResponse res =
            await databases.retrieve(databaseId: testDatabaseId ?? '');

        /// TODO: Separate test and retrieve database on a `setUp`.
        expect(res.status, 200);
        expect(res.isOk, isTrue);
        expect(res.isDatabase, isTrue);
        expect(res.content, isA<Database>());

        // Can read the title
        expect(res.database!.title, 'New Title');

        // Can read properties main column.
        expect(res.database!.properties.getByName('This is a test'),
            isA<TitleDbProp>());

        // Can read multiselect property options
        expect(
            res.database!.properties
                .getByName('Tags')
                .asMultiSelect
                .options
                .length,
            1);
      });
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      NotionResponse res = await databases.list();

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve all databases with wrong query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      NotionResponse res = await databases.list(startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve all databases with query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      const int limit = 2;
      NotionResponse res = await databases.list(pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });

    group('Create', () {
      test('Create a database with title', () async {
        final NotionDatabasesClient databases =
            NotionDatabasesClient(auth: token ?? '');

        NotionResponse res = await databases.create(
          pageId: testPageId ?? '',
          title: 'Database from test',
          properties: DatabaseProperties(
            mainColumnName: 'ABC',
            properties: {
              'Description': DatabaseProperty.RichText(),
              'Done': DatabaseProperty.Checkbox(),
            },
          ),
        );

        expect(res.status, 200);
        expect(res.isOk, true);
      });

      test('Create a database without title', () async {
        final NotionDatabasesClient databases =
            NotionDatabasesClient(auth: token ?? '');

        NotionResponse res = await databases.create(
          pageId: testPageId ?? '',
          properties: DatabaseProperties(mainColumnName: 'Title Column'),
        );

        expect(res.status, 200);
        expect(res.isOk, true);
      });
    });

    test('Update a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(auth: token ?? '');

      NotionResponse res = await databases.update(
          databaseId: '8bd452157e1642dd8aad5734a2372518',
          title: [RichText('New Title')],
          properties: Properties(map: {
            'Test': MultiSelectProp(
              options: [
                MultiSelectOption(name: 'Read', color: ColorsTypes.Blue),
                MultiSelectOption(name: 'Sleep', color: ColorsTypes.Green),
              ],
            ),
            'Column': RichTextProp()
          }));

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });

  group('Notion Block Client =>', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.list(block_id: testBlockId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve block children with wrong query', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res =
          await blocks.list(block_id: testBlockId ?? '', startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve block children with query', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      const int limit = 2;
      NotionResponse res =
          await blocks.list(block_id: testBlockId ?? '', pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });

    test('Append heading & text', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks([
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
        ]),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append todo block', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks([
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
          ])
        ]),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append bulleted list item block', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks(
          [
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
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Colors', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');
      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks(
          [
            Paragraph(
              texts: [
                ...Text.list(texts: [
                  Text(
                    'gray',
                    annotations: TextAnnotations(color: ColorsTypes.Gray),
                  ),
                  Text(
                    'brown',
                    annotations: TextAnnotations(color: ColorsTypes.Brown),
                  ),
                  Text(
                    'orange',
                    annotations: TextAnnotations(color: ColorsTypes.Orange),
                  ),
                  Text(
                    'yellow',
                    annotations: TextAnnotations(color: ColorsTypes.Yellow),
                  ),
                  Text(
                    'green',
                    annotations: TextAnnotations(color: ColorsTypes.Green),
                  ),
                  Text(
                    'blue',
                    annotations: TextAnnotations(color: ColorsTypes.Blue),
                  ),
                  Text(
                    'purple',
                    annotations: TextAnnotations(color: ColorsTypes.Purple),
                  ),
                  Text(
                    'pink',
                    annotations: TextAnnotations(color: ColorsTypes.Pink),
                  ),
                  Text(
                    'red',
                    annotations: TextAnnotations(color: ColorsTypes.Red),
                  ),
                  Text(
                    'default',
                    annotations: TextAnnotations(color: ColorsTypes.Default),
                  ),
                ]),
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append numbered list item block', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks(
          [
            NumberedListItem(text: Text('This is a numbered list item A')),
            NumberedListItem(text: Text('This is a numbered list item B')),
            NumberedListItem(
              text: Text('This is a bulleted list item with children'),
              children: [
                Paragraph(texts: [
                  Text(
                    'This paragraph start with color gray ',
                    annotations: TextAnnotations(color: ColorsTypes.Gray),
                  ),
                  Text(
                    'and end with brown',
                    annotations: TextAnnotations(color: ColorsTypes.Brown),
                  ),
                ])
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append toggle block', () async {
      final NotionBlockClient blocks = NotionBlockClient(auth: token ?? '');

      NotionResponse res = await blocks.append(
        block_id: testBlockId as String,
        children: Children.withBlocks(
          [
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
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });
}
