# Changelog

All notable changes to
[the `graphqelm` elm package](http://package.elm-lang.org/packages/dillonkearns/graphqelm/latest)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [11.1.0] - 2018-03-21

### Added

* Add `mapError` and `ignoreParsedErrorData` functions to allow you to do more
  manipulation of `ParsedData` within Error data (fixes #52).

## [11.0.0] - 2018-03-21

### Changed

* Responses are errors if any data is present in `errors` field in response.
  The `data` field from the response is also included in `GraphqlError`s now so
  you can inspect the data upon failure. Here is a summary of how this will effect your code:
  * Before, Graphqelm always treated responses where it could parse the response as success.
  * Now, it will treat responses where `errors` are present as an error regardless of whether it is able to parse the response `data`.
  * Users will need to add a type variable to their error type as errors may contain parsed data now (so `RemoteData (Graphqelm.Http.Error) Response` -> `RemoteData (Graphqelm.Http.Error Response) Response`)
  * For more context, here's the Github issue: https://github.com/dillonkearns/graphqelm/issues/48#issuecomment-373175596
  * For an example, see https://github.com/dillonkearns/graphqelm/blob/30be3570f52f5fd73055321e1a998c4082db32cf/examples/src/ErrorHandling.elm#L80-L107

## [10.2.0] - 2018-03-09

### Added

* Add `SelectionSet.succeed` to provide a hardcoded value as the result of a
  SelectionSet.

## [10.1.0] - 2018-02-25

### Changed

* Expose GraphQL response decoder publicly.

## [10.0.0] - 2018-02-07

### Changed

* Update model to allow more flexibility based on #32.

## [9.1.0] - 2018-02-06

### Added

* Add functions for transforming `Field`s using `Result`s. These functions are
  handy for converting values into types like `DateTime`s but can cause your
  entire response to error when decoding if any incorrect assumptions are made
  so they should be used with extreme care.

## [9.0.0] - 2018-01-28

### Changed

* Remove `AlwaysPost` since `Graphqelm.Http.queryRequest` now always uses POST.
  Added option to `GetWhenShortEnough`.

### Added

* Add `Graphqelm.OptionalArgument.fromMaybe`.
* Add `SelectionSet.map`.

## [8.0.1] - 2018-01-27

### Changed

* Always use POST when sending query requests since some APIs like Github don't
  support GET (see https://developer.github.com/v4/guides/forming-calls/#communicating-with-graphql).

## [8.0.0] - 2018-01-27

### Added

* Add `Graphqelm.Http.withQueryParams`.

### Changed

* Use GET requests by default when sending a query request, unless the resulting
  url would be over 2000 characters. `queryParamsForceMethod` allows you to specify a method when needed.
* Rename `Graphqelm.Http` functions from `buildMutationRequest` => `mutationRequest`
  and `buildQueryRequest` => `queryRequest` to sound more declarative and concise.
* Extract Subscription.Protocol module which encapsulates the details about
  low-level subscription communication for a given framework. The module includes
  an implementation for Rails and Absinthe/Rhoenix, or custom.

## [7.2.0] - 2018-01-20

### Added

* Add experimental subscriptions module and example.

## [7.1.0] - 2018-01-18

### Added

* Add `Graphqelm.Http.toTask`.
* Expose `Graphqelm.Http.withCredentials`.

## [7.0.0] - 2018-01-17

### Changed

* Rename `FieldDecoder` type and module to `Field` to match GraphQL domain language more closely.

## [6.1.0] - 2018-01-11

### Added

* Add `hardcoded` function to add arbitrary constants alongside `with` calls.

## [6.0.0] - 2018-01-10

### Added

* Expose Http.Error constructors.

## [5.0.1] - 2018-01-10

### Removed

* Remove unused elm package dependencies.

## [5.0.0] - 2018-01-10

### Fixed

* Add missing `Encode.float` function. Without this, APIs with float arguments
  would have compilation errors.

### Changed

* Modules that are used only by generated code are now under `Graphqelm.Internal`
  to make it more clear in the documentation.

## [4.1.0] - 2018-01-08

### Added

* Encode functions to support generated code for input objects.
  There is now no reason for users to consume the Encode module directly! It's
  all done under the hood by the generated code.

## [4.0.1] - 2018-01-07

### Fixed

* Fix bug that excluded arguments when serializing leaves in document.
