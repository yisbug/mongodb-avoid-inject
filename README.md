### mongodb防注入

之前没有关注到mongodb注入问题，临时解决办法，检验请求中所有关键词。

以后有空再单独研究一下mongodb防注入问题。

``` coffee
restify = require 'restify'
server = restify.createServer()
server.use require 'mongodb-avoid-inject'
```


