var utils;

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
