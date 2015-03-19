module.exports = (req,res,next)->
    # req.params
    # req.body
    disableList = [
        '$inc'
        '$set'
        '$unsert'
        '$push'
        '$ne'
        '$addToSet'
        '$each'
        '$pop'
        '$pull'
        '$'
        '$lt'
        '$lte'
        '$gt'
        '$gte'
        '$or'
        '$in'
        '$nin'
        '$mod'
        '$not'
        '$exists'
        '$slice'
        '$size'
        '$where'
    ]
    onError = ->
        res.send 400,'disable arguments'
    isDisable = (obj)->
        bool = false # ok
        for key,value of obj
            return true if disableList.indexOf(key)>-1
            return true if typeof value is 'object' and isDisable(value)
        return false
    return onError() if req.params and isDisable req.params
    return onError() if req.body and isDisable req.body
    next()
