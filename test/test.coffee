restify = require 'restify'
should = require 'should'
assert = require 'assert'


port = 5000

server = ''
client = ''
describe '测试',->
    before (done)->
        server = restify.createServer()
        server.use restify.authorizationParser()
        server.use restify.bodyParser mapParams:false
        server.use restify.queryParser()
        server.use require '../coffee/'
        server.post '/user',(req,res,next)->
            username = req.body.username
            password = req.body.password
            if typeof username is 'string'
                return res.send 200,'ok'
            console.log username,password
            res.send 200,'ok'

        client = restify.createJsonClient url:'http://localhost:'+port

        server.listen port,->
            console.log 'server start.'
            done()
    after (done)->
        server.close()
        done()
    describe 'post',->
        it 'post /user , $ne',(done)->
            client.post '/user',{
                username:'$ne':1
            },(err,req,res,obj)->
                assert.ifError 'must error.' if not err
                err.statusCode.should.be.equal 400
                err.body.should.be.equal 'disable arguments'
                done()
        it 'post /user',(done)->
            client.post '/user',{
                username:'test'
                password:'test'
            },(err,req,res,obj)->
                assert.ifError err
                res.statusCode.should.be.equal 200
                done()