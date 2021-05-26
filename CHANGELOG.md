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