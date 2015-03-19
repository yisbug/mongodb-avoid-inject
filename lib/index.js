(function() {
  module.exports = function(req, res, next) {
    var disableList, isDisable, onError;
    disableList = ['$inc', '$set', '$unsert', '$push', '$ne', '$addToSet', '$each', '$pop', '$pull', '$', '$lt', '$lte', '$gt', '$gte', '$or', '$in', '$nin', '$mod', '$not', '$exists', '$slice', '$size', '$where'];
    onError = function() {
      return res.send(400, 'disable arguments');
    };
    isDisable = function(obj) {
      var bool, key, value;
      bool = false;
      for (key in obj) {
        value = obj[key];
        if (disableList.indexOf(key) > -1) {
          return true;
        }
        if (typeof value === 'object' && isDisable(value)) {
          return true;
        }
      }
      return false;
    };
    if (req.params && isDisable(req.params)) {
      return onError();
    }
    if (req.body && isDisable(req.body)) {
      return onError();
    }
    return next();
  };

}).call(this);
