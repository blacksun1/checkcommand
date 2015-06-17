checkcommand
------------

[![npm version](https://badge.fury.io/js/checkcommand.svg)](http://badge.fury.io/js/checkcommand)
[![dependencies](https://david-dm.org/jviotti/checkcommand.png)](https://david-dm.org/jviotti/checkcommand.png)
[![Build Status](https://travis-ci.org/jviotti/checkcommand.svg?branch=master)](https://travis-ci.org/jviotti/checkcommand)
[![Build status](https://ci.appveyor.com/api/projects/status/xnlub819ghm43sd1?svg=true)](https://ci.appveyor.com/project/jviotti/checkcommand)

Check that a command exists, throw an error message of your choice otherwise.

Installation
------------

Install `checkcommand` by running:

```sh
$ npm install --save checkcommand
```

Documentation
-------------

### checkcommand.ensure(String command, String message[, Function callback])

Ensure that a command exists. Throw an error with `message` otherwise.

This function supports promises.

Example:

```coffee
checkcommand = require('checkcommand')

message = '''
	Wget is missing from your system. Install it from brew:
		
		$ brew install wget
'''

checkcommand.ensure('wget', message).then ->
	console.log('It seems that wget is installed!')
.catch (error) ->
	console.error(error)
```

***

```coffee
checkcommand = require('checkcommand')

message = '''
	Wget is missing from your system. Install it from brew:
		
		$ brew install wget
'''

checkcommand.ensure 'wget', message, (error) ->
	if error?
		console.error(error.message)
	else
		console.log('It seems that wget is installed!')
```

### checkcommand.ensureMultiple(Object commands[, Function callback])

Ensure multiple commands. A utility function to prevent calling `checkcommand.ensure()` multiple times.

The `commands` object contains command names as property keys, and error messages as values.

Example:

```coffee
checkcommand = require('checkcommand')

checkcommand.ensureMultiple
	'wget': 'Missing wget'
	'curl': 'Missing curl'
.then ->
	console.log('It seems that wget and curl are installed!')
.catch (error) ->
	console.error(error)
```

***

```coffee
checkcommand = require('checkcommand')

checkcommand.ensureMultiple
	'wget': 'Missing wget'
	'curl': 'Missing curl'
, (error) ->
	if error?
		console.error(error.message)
	else
		console.log('It seems that wget and curl are installed!')
```

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

Contribute
----------

- Issue Tracker: [github.com/jviotti/checkcommand/issues](https://github.com/jviotti/checkcommand/issues)
- Source Code: [github.com/jviotti/checkcommand](https://github.com/jviotti/checkcommand)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/jviotti/checkcommand/issues/new) on GitHub.

License
-------

The project is licensed under the MIT license.
