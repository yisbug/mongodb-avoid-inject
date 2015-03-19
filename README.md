### mongodb防注入

之前没有关注到mongodb注入问题，临时解决办法，检验请求中所有关键词。

以后有空再单独研究一下mongodb防注入问题。


### 安装

    npm install mongodb-avoid-inject


### 使用

需要`restify.bodyParser()`和`restify.queryParser()`

``` coffee
restify = require 'restify'
server = restify.createServer()
server.use restify.bodyParser mapParams:false
server.use restify.queryParser()
server.use require 'mongodb-avoid-inject'
```

如果请求包含关键词则返回http 400错误。
