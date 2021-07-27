import 'dart:io' show Platform;

import 'package:dotenv/dotenv.dart' show load, env, clean;
import 'package:notion_api/notion/blocks/bulleted_list_item.dart';
import 'package:notion_api/notion/blocks/heading.dart';
import 'package:notion_api/notion/blocks/numbered_list_item.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/blocks/toggle.dart';
import 'package:notion_api/notion/general/lists/properties.dart';
import 'package:notion_api/notion/general/property.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/lists/children.dart';
import 'package:notion_api/notion/objects/database.dart';
import 'package:notion_api/notion/objects/pages.dart';
import 'package:notion_api/notion.dart';
import 'package:notion_api/notion/objects/parent.dart';
import 'package:notion_api/notion_blocks.dart';
import 'package:notion_api/notion_databases.dart';
import 'package:notion_api/notion_pages.dart';
import 'package:notion_api/responses/notion_response.dart';
import 'package:notion_api/notion/general/rich_text.dart';
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
      final NotionClient notion = NotionClient(token: token ?? '');
      NotionResponse res = await notion.pages.fetch(testPageId ?? '');

      expect(res.status, 200);
      expect(res.isPage, true);
      expect(res.content, isNotNull);
      expect(res.content, isA<Page>());
      expect(res.isOk, true);
    });
  });

  group('Notion Pages Client =>', () {
    test('Create a page', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
        title: Text('NotionClient (v1): Page test'),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Create a page with default title', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
      );

      var res = await pages.create(page);

      expect(res.status, 200);
    });

    test('Create a page with full example', () async {
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
            Text(
              'Paragraph',
              annotations: TextAnnotations(code: true),
            ),
            Text(', '),
            Text(
              'ToDo',
              annotations: TextAnnotations(code: true),
            ),
            Text(', '),
            Text(
              'BulletedListItems',
              annotations: TextAnnotations(code: true),
            ),
            Text(' or '),
            Text(
              'NumberedListItems',
              annotations: TextAnnotations(code: true),
            ),
            Text('.'),
          ]),
          Paragraph(
            text: Text(
              'Also, if your paragraph will have the same style you can write all your text directly like this to avoid using a list.',
            ),
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

      final NotionClient notion = NotionClient(token: token ?? '');

      final Page page = Page(
        parent: Parent.database(id: testDatabaseId ?? ''),
        title: Text('notion_api example'),
      );

      var newPage = await notion.pages.create(page);

      String newPageId = newPage.page!.id;

      var res = await notion.blocks.append(
        to: newPageId,
        children: fullContent,
      );

      expect(res.status, 200);
    });

    test('Update a page (properties)', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      var res = await pages.update('15db928d5d2a43ada59e3136663d41f6',
          properties: Properties(map: {
            'Property': RichTextProp(content: [Text('A')])
          }));

      expect(res.status, 200);
    });

    test('Update a page (archived)', () async {
      final NotionPagesClient pages = NotionPagesClient(token: token ?? '');

      var res = await pages.update('15db928d5d2a43ada59e3136663d41f6',
          archived: false);

      expect(res.status, 200);
    });
  });

  group('Notion Databases Client =>', () {
    test('Retrieve a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetch(testDatabaseId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve all databases', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetchAll();

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve all databases with wrong query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.fetchAll(startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve all databases with query', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      const int limit = 2;
      NotionResponse res = await databases.fetchAll(pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });

    test('Create a database', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.create(Database.newDatabase(
        parent: Parent.page(id: testPageId ?? ''),
        title: [
          Text('Database from test'),
        ],
        pagesColumnName: 'Custom pages column',
        properties: Properties(map: {
          'Description': MultiSelectProp(options: [
            MultiSelectOption(name: 'Read', color: ColorsTypes.Blue),
            MultiSelectOption(name: 'Sleep', color: ColorsTypes.Green),
          ])
        }),
      ));

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Create a database with default', () async {
      final NotionDatabasesClient databases =
          NotionDatabasesClient(token: token ?? '');

      NotionResponse res = await databases.create(Database.newDatabase(
        parent: Parent.page(id: testPageId ?? ''),
      ));

      expect(res.status, 200);
      expect(res.isOk, true);
    });
  });

  group('Notion Block Client =>', () {
    test('Retrieve block children', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.fetch(testBlockId ?? '');

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Retrieve block children with wrong query', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res =
          await blocks.fetch(testBlockId ?? '', startCursor: '');

      expect(res.status, 400);
      expect(res.code, 'validation_error');
      expect(res.isOk, false);
      expect(res.isError, true);
    });

    test('Retrieve block children with query', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      const int limit = 2;
      NotionResponse res =
          await blocks.fetch(testBlockId ?? '', pageSize: limit);

      expect(res.isOk, true);
      expect(res.isList, true);
      expect(res.content.length, lessThanOrEqualTo(limit));
    });

    test('Append complex stuff', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks([
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
              Text(
                'Paragraph',
                annotations: TextAnnotations(code: true),
              ),
              Text(', '),
              Text(
                'ToDo',
                annotations: TextAnnotations(code: true),
              ),
              Text(', '),
              Text(
                'BulletedListItems',
                annotations: TextAnnotations(code: true),
              ),
              Text(' or '),
              Text(
                'NumberedListItems',
                annotations: TextAnnotations(code: true),
              ),
              Text('.'),
            ]),
            Paragraph(
              text: Text(
                'Also, if your paragraph will have the same style you can write all your text directly like this to avoid using a list.',
              ),
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
        ]),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append heading & text', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
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
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
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
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
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
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');
      NotionResponse res = await blocks.append(
        to: testBlockId as String,
        children: Children.withBlocks(
          [
            Paragraph(
              texts: [
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
              ],
            ),
          ],
        ),
      );

      expect(res.status, 200);
      expect(res.isOk, true);
    });

    test('Append numbered list item block', () async {
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
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
      final NotionBlockClient blocks = NotionBlockClient(token: token ?? '');

      NotionResponse res = await blocks.append(
        to: testBlockId as String,
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
