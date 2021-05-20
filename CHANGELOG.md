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
* Add `database` request parameters models
* Add notion api endpoints: `databases`
  * Retrieve a database
  * Retrieve all databases
    * Note: `page_size` & `start_cursor` query parameters are available
* Add `database` tests