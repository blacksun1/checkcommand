chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
chai.use(require('chai-as-promised'))
Promise = require('bluebird')
checkcommand = require('../lib/checkcommand')
utils = require('../lib/utils')

describe 'Checkcommand:', ->

	describe '.ensure()', ->

		describe 'given the command exists', ->

			beforeEach ->
				@utilsExistsStub = sinon.stub(utils, 'exists')
				@utilsExistsStub.returns(Promise.resolve(true))

			afterEach ->
				@utilsExistsStub.restore()

			it 'should be resolved', ->
				promise = checkcommand.ensure('wget', 'Install it from brew')
				expect(promise).to.be.fulfilled

			it 'should not yield an error', (done) ->
				checkcommand.ensure 'wget', 'Install it from brew', (error) ->
					expect(error).to.not.exist
					done()

		describe 'given the command does not exist', ->

			beforeEach ->
				@utilsExistsStub = sinon.stub(utils, 'exists')
				@utilsExistsStub.returns(Promise.resolve(false))

			afterEach ->
				@utilsExistsStub.restore()

			it 'should reject with the passed message', ->
				promise = checkcommand.ensure('wget', 'Install it from brew')
				expect(promise).to.be.rejectedWith('Install it from brew')

			it 'should yield an error containing the message', (done) ->
				checkcommand.ensure 'wget', 'Install it from brew', (error) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('Install it from brew')
					done()

	describe '.ensureMultiple()', ->

		describe 'given all commands exist', ->

			beforeEach ->
				@utilsExistsStub = sinon.stub(utils, 'exists')
				@utilsExistsStub.returns(Promise.resolve(true))

			afterEach ->
				@utilsExistsStub.restore()

			it 'should be resolved', ->
				promise = checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'

				expect(promise).to.be.fulfilled

			it 'should not yield an error', (done) ->
				checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'
				, (error) ->
					expect(error).to.not.exist
					done()

		describe 'given one commands does not exist', ->

			beforeEach ->
				@utilsExistsStub = sinon.stub(utils, 'exists')
				@utilsExistsStub.withArgs('wget').returns(Promise.resolve(true))
				@utilsExistsStub.withArgs('curl').returns(Promise.resolve(false))
				@utilsExistsStub.withArgs('axel').returns(Promise.resolve(true))

			afterEach ->
				@utilsExistsStub.restore()

			it 'should be rejected with the corresponding message', ->
				promise = checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'
				expect(promise).to.be.rejectedWith('Missing curl')

			it 'should yield the corresponding error message', (done) ->
				checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'
				, (error) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('Missing curl')
					done()

		describe 'given no command exist', ->

			beforeEach ->
				@utilsExistsStub = sinon.stub(utils, 'exists')
				@utilsExistsStub.returns(Promise.resolve(false))

			afterEach ->
				@utilsExistsStub.restore()

			it 'should be rejected', ->
				promise = checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'
				expect(promise).to.be.rejected

			it 'should yield an error', (done) ->
				checkcommand.ensureMultiple
					'wget': 'Missing wget'
					'curl': 'Missing curl'
					'axel': 'Missing axel'
				, (error) ->
					expect(error).to.be.an.instanceof(Error)
					done()
