Jam.define("mainview",function(){
    var service = "MainViewBridge";
    var sendMsg = function(msg){
        Jam.exec(service,"messagesend",msg);
    }
    var getValue = function(delegate){
        Jam.exec(service,"getvalue",123 ,function(value){
            delegate.call(this,value);
        });
    }
    var startUpdate = function(delegate){
        Jam.exec(service,"startUpdate",function(value){
            delegate.call(this,value);
        });
    }
    var stopUpdate = function(){
        Jam.exec(service,"stopUpdate");
    }
    
    //TODO: add params demo
    return {
        sendMsg:sendMsg,
        getValue:getValue,
        startUpdate:startUpdate,
        stopUpdate:stopUpdate
    }
});
var mainview = Jam.require("mainview");