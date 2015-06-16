utils = require('./utils')

###*
# @summary Ensure a command exists.
# @function
# @public
#
# @description
# Throws an error message of your choice otherwise.
#
# @param {String} command - command
# @param {String} message - error message
# @returns {Promise}
#
# @example
# checkcommand.ensure('wget', 'Install wget from brew:\n\t$ brew install wget')
###
exports.ensure = (command, message, callback) ->
	utils.exists(command).then (exists) ->
		throw new Error(message) if not exists
	.nodeify(callback)
