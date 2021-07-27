# Roadmap

## More coming soon...
If you have suggestions feel free to create an Issue or to create a PR with the feature.

## v1.3.0
> Release date: 06/Aug/2021
* Maybe fix errors creating page with children. I don't know if is an error with Notion API.
* Add query a database endpoint:
  * https://developers.notion.com/reference/post-database-query
* Add more properties for pages and databases:
  * Page properties: https://developers.notion.com/reference/page#page-property-value
  * Database properties: https://developers.notion.com/reference/database#database-property

## v1.2.1:
> Release date: 02/Aug/2021
* Add constructors with only single text content with default style for:
  * `Paragraph.text('some text here...')`
  * `ToDo.text('some text here...', checked: true)`
  * `Heading.text('some text here...', type: 2)`
  * `BulletedListItem.text('some text here...')`
  * `NumberedListItem.text('some text here...')`
  * `Toggle.text('some text here...', children: [])`
* Add more constructors for `Heading` class:
  * `one`: Heading with type 1 by default.
  * `two`: Heading with type 2 by default.
  * `three`: Heading with type 3 by default.
* Add more constructors for `Text` class:
  * `code`: Text with code style by default.
  * `italic`: Text with italic style by default.
  * `bold`: Text with bold style by default.
  * [**Opt**] `list`: List of words separated by comma (by default).
    * Example: `Text.list()` will receive a list of Text and will be concatenated separated with comma by default. **It may be unnecessary**. Can help to make the code more readable.
  * [**Opt**] `sep`: Text separator.
    * Example: `Text.sep()`, by default, will insert " " in a list of `Text` instances, but it will be able to do more things that I don't know yet, hehe. **It may be unnecessary**. Can help to make the code more readable.

## v1.2.0: ✅
> Release date: 27/Jul/2021
* Implement new endpoints
  * Update page: https://developers.notion.com/reference/patch-page#archive-delete-a-page
  * Create database: https://developers.notion.com/reference/create-a-database
* Add `Page` support for responses
* Add more colors for Text
* Add list of endpoints implemented on package
* Improve coverage

## v1.1.0: ✅
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

## v1.0.2: ✅
> Release date: 05/Jul/2021
* Fix warnings for documentation
* Improve documentation
* Add contribution rules

## v1.0.1: ✅
> Release date: 04/Jul/2021
* Fix Notion-Version header missing

## v1.0.0: ✅
> Release date: 25/Jun/2021
* Fix any error
* Add library-documentation

## v1.0.0-beta2: ✅
> Release date: 22/Jun/2021
* Fix any error
* Tests for every piece of code
* Improve coverage
* Improve docs

## v1.0.0-beta1: ✅
> Release date: 15/Jun/2021
* Improve code implementation
  * Refactor package structure
  * Refactor some properties & function names
  * Add useful functions
  * Separate classes to avoid duplicated code
* Add more tests
  * Separate tests by sections
* Improve code documentation
* Improve Pub Points
* Add custom response
* Remove dependency for `flutter`

## v0.0.1: ✅
> Release date: 01/Jun/2021
* Improve testing
* Improve Rich Text usage
* Add more blocks for `(PATCH): block children` endpoint
  * `ToDo` block

## v0.0.1-beta1: ✅
> Release date: 26/May/2021
* Update to null-safety
* Improve environment variables implementation
* Add CI with GitHub Actions
* Add notion api endpoints: `block children`
  * Retrieve block children
  * Append block children
* Add `block children` API request tests

## v0.0.1-dev.2: ✅
> Release date: 20/May/2021
* [NOT_NEEDED_YET] ~~Add `database` request parameters models~~
* Add notion api endpoints: `databases`
  * Retrieve a database
  * List databases
  * [LATER] ~~Query a database~~
* Add `database` tests

## v0.0.1-dev.1: ✅
> Release date: 20/May/2021
* [CANCELED] ~~Return data response directly instead of `http.Response`~~
* [CANCELED] ~~Manage http calls errors~~
* Separate into classes

## v0.0.1-prealpha1: ✅
> Release date: 20/May/2021
* First version
* Add `page` requests parameters models
* Add notion api endpoints: `pages`
  * Retrieve a page
  * Create a page
    * Note: Accept only basic content: `title` & `parent`.
* Add `database` tests
