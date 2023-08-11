# Changelog
## v0.0.1-prealpha1
> Release date: 20/May/2021
* First version
* Add `page` requests parameters models
* Add notion api endpoints: `pages`
  * Retrieve a page
  * Create a page
    * Note: Accept only basic content: `title` & `parent`.
* Add `database` tests

## v0.0.1-dev.1:
> Release date: 20/May/2021
* Separate into classes

## v0.0.1-dev.2:
> Release date: 20/May/2021
* Add notion api endpoints: `databases`
  * Retrieve a database
  * Retrieve all databases
    * Note: `page_size` & `start_cursor` query parameters are available
* Add `database` tests
* Add `title` field to `Page` constructor
* Add static API information (host, api version) on separated file

## v0.0.1-beta1:
> Release date: 26/May/2021
* Update to null-safety
* Improve environment variables implementation
* Add CI with GitHub Actions
* Add notion api endpoints: `block children`
  * Retrieve block children
  * Append block children
    * Note: Only `Paragraph` (with `Text`) & `Heading` types are working
* Add `block children` API request tests

## v0.0.1:
> Release date: 01/Jun/2021
* Improve testing
* Improve Rich Text usage
* Add more blocks for `(PATCH): block children` endpoint
  * `ToDo` block

## v1.0.0-beta1:
> Release date: 16/Jun/2021
* Improve code implementation
  * Refactor package structure
  * Refactor some properties & function names
  * Add useful functions
  * Separate classes to avoid duplicated code
* Add more tests
  * Tests for every piece of code
  * Separate tests by sections
* Improve code documentation
* Improve Pub Points
* Add custom response
* Remove dependency for `flutter`

## v1.0.0-beta2:
> Release date: 22/Jun/2021
* Fix any error
* Tests for every piece of code
* Improve coverage
* Improve docs

## v1.0.0:
> Release date: 25/Jun/2021
* Fix any error
* Add library-documentation

## v1.0.1:
> Release date: 04/Jul/2021
* Fix Notion-Version header missing

## v1.0.2:
> Release date: 05/Jul/2021
* Fix warnings for documentation
* Improve documentation
* Add contribution rules

## v1.1.0:
> Release date: 10/Jul/2021
* Add more blocks support for `(PATCH): block children` endpoint
  * `BulletedListItem` block
  * `NumberedListItem` block
  * `Toggle` block
* Add `children` field for blocks:
  * `BulletedListItem`
  * `NumberedListItem`
  * `ToDo`
  * `Toggle`
  * `Paragraph`
* Add methods to manipulate `content` and `children` for blocks:
  * `addText(String text, {TextAnnotations? annotations})`
  * `addChild(Block block)`
  * `addChildren(List<Block> blocks)`
* Add `Children.withBlocks(List<Block> blocks)` constructor
* Add `final` for `type` fields to not allow overwrite:
  * Objects
  * Blocks
* Add `BaseClient` class to avoid duplicated code for clients
* Add `deprecated` annotations for future changes:
  * Remove `textSeparation` parameter/field
  * Remove `add(Text text)` function
  * Remove `texts` getter for `Paragraph`
  * Remove named parameters for `Children` class
* Update documentation

## v2.0.0-beta1
> Release date: 30/Aug/2021
* 🐣 Add constructor for empty `Database`.
* 🐣 Add parameter `blocks` for `Children` constructor.
* 🍗 Remove deprecated code:
  * `textSeparation`
  * Parameter constructors for `Children`:
    * `heading`
    * `paragraph`
    * `toDo`
* 🐣 Add suggestions on issue [#11](https://github.com/jonathangomz/notion_api/issues/11):
  * Update exports to improve usage
  * Add private folder (`src/`)
* 🐣 Add constructors with only single text content with default style for:
  * `Paragraph`: `Paragraph.text('some text here...')`
  * `ToDo`: `ToDo.text('some text here...', checked: true)`
  * `Heading`: `Heading.text('some text here...', type: 2)`
  * `BulletedListItem`: `BulletedListItem.text('some text here...')`
  * `NumberedListItem`: `NumberedListItem.text('some text here...')`
  * `Toggle`: `Toggle.text('some text here...', children: [])`
* 🐣 Add more constructors for `Heading` class:
  * `one`: Heading with type 1 by default.
  * `two`: Heading with type 2 by default.
  * `three`: Heading with type 3 by default.
* 🐣 Add more constructors for `Text` class:
  * `code`: Text with code style by default.
  * `italic`: Text with italic style by default.
  * `bold`: Text with bold style by default.
  * `underline`: Text with underline style by default.
  * `color`: Text with different color of default.
* 🐣 Add `list(List<Text> texts, String separator, String lastSeparator)`:
  *  **A static method**
  *  Generate a textual list of texts separated by comma (by default).

## v2.0.0-beta2
> Release date: 06/Aug/2021
* 🍗 Add more suggestions on issue [#11](https://github.com/jonathangomz/notion_api/issues/11):
  * Copy some terminologies from [`notion-sdk-js`](https://github.com/makenotion/notion-sdk-js)