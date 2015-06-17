var Promise, utils, _;

_ = require('lodash');

Promise = require('bluebird');

utils = require('./utils');


/**
 * @summary Ensure a command exists.
 * @function
 * @public
 *
 * @description
 * Throws an error message of your choice otherwise.
 *
 * @param {String} command - command
 * @param {String} message - error message
 * @returns {Promise}
 *
 * @example
 * checkcommand.ensure('wget', 'Install wget from brew:\n\t$ brew install wget')
 */

exports.ensure = function(command, message, callback) {
  return utils.exists(command).then(function(exists) {
    if (!exists) {
      throw new Error(message);
    }
  }).nodeify(callback);
};


/**
 * @summary Ensure multiple commands at the same time.
 * @function
 * @public
 *
 * @param {Object} commands - commands
 * @returns {Promise}
 *
 * @example
 * checkcommand.ensureMultiple
 *		'wget': 'Missing wget'
 *		'curl': 'Missing curl'
 *		'axel': 'Missing axel'
 */

exports.ensureMultiple = function(commands, callback) {
  var ensurePromises;
  ensurePromises = _.map(_.pairs(commands), function(command) {
    return exports.ensure(_.first(command), _.last(command));
  });
  return Promise.all(ensurePromises).nodeify(callback);
};
