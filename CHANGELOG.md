## 0.6.0

* **BREADKING CHANGE** `ensureInitialized` now return `void` instead of `bool`.
* Use `fetchAndDecode` to make it more reliable.

## 0.5.0

* Bump dart min sdk to 3.2.0.
* Bump firebase_remote_config to 5.0.3.

## 0.4.0

* Update depencencies.
* **Breadking change** In `.asList`, `.asMap`, `getList` and `getMap`, an empty value will be returned if there is error occurs. If `onError` is null, an exception will be thrown.

## 0.3.2

* Improve the fetch and activate behavior.
* Update dependencies.

## 0.3.1

* Update comments.
* Update homepage URL.

## 0.3.0

* Bump sdk to ">=2.18.0 <4.0.0" and flutter to ">=3.3.0"

## 0.2.0

* Bump `firebase_remote_config` to `^4.0.0`.

## 0.1.1

* Automatically using `jsonEncode` to encode `Map<String, Object>` and `List<Object>`.
* Add `onError` parameter to `.asMap` and `.asList` extensions to set the value if error occurs instead of throw exception.
* Add more tests.

## 0.1.0

* Upgrade dependencies.

## 0.0.1+7

* Improved README.
* Update dependencies.

## 0.0.1+6

* Add try catch to allow the `initial` method runs without internet connected.

## 0.0.1+5

* Improved Map and List typecast.

## 0.0.1+4

* [BREAKING CHANGE] Change from `getBoolean` to `getBool`.
* Improves README
* Prevent initialize this plugin again
* Update dependencies

## 0.0.1+3

* Supports type List.

## 0.0.1+2

* Move from package > plugin
* Improve README
  
## 0.0.1

* Initial release.
