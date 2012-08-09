var Jam ,require,define;
(function () {
    var modules = {};

    function build(module) {
        var factory = module.factory;
        module.exports = {};
        delete module.factory;
        console.debug("init module " + module.id);
        module.exports = factory(require, module.exports, module);
        return module.exports;
    }

    require = function (id) {
        if (!modules[id]) {
            throw "module " + id + " not found";
        }
        return modules[id].factory ? build(modules[id]) : modules[id].exports;
    };

    define = function (id, factory) {
        if (modules[id]) {
            throw "module " + id + " already defined";
        }

        modules[id] = {
            id: id,
            factory: factory
        };
    };

    define.remove = function (id) {
        delete modules[id];
    };
    
    var importScript = function(path){
    	document.write('<script src="'+path+'" type="text/javascript"><\/'+'script>');
    };
        
    Jam = {
        importScript : importScript,
        require : require,
        define  : define
    }
})();

Jam.define("bridge",function(){
    var callbacks = {}
    var callback_count = 0;
    var exec_message = function(service,message,params,callback){
    	if(!message) return;
    	scheme = 'ajam';
    	var url = scheme+':'+ service + '.' + message;
    	
    	if (typeof(params) == 'function'){
    	    if(!callback)
        	    callback = params , params = null ;
        	else
                return; //argus error
    	}
    	        	    
    	if (callback) {
    	    callback_count += 1;
    	    callbacks[callback_count] = callback;    	    
    	    url += "/" + callback_count;
    	};
    	
    	if (params)
    	    url += "?" + encodeURIComponent(JSON.stringify(params));
    	console.debug(url);
        // window.location.href = url;
    };
    
    var callback = function(id,is_remove,args){
        fun_callback = callbacks[id];
        if (!fun_callback) return;
        fun_callback.call(this,args)
        if(is_remove)
            delete callbacks[id];        
    }
    Jam.exec = exec_message;
    Jam.callback = exec_message.callback;    
    return {exec:exec_message,callback:callback};
});


Jam.define('ready',function(){
     var timer = setInterval(
         function(){
             var state = document.readyState;
             if ( ( state == 'loaded' || state == 'complete' ) ) {
                 console.debug("document ready");
                 clearInterval(timer);
                 var e = document.createEvent('Events');
                 e.initEvent('jam_loaded',true,true);
                 document.dispatchEvent(e);
             }
        } , 1);
    Jam.ready = function(ready_callback){
        var state = document.readyState;
        if ( ( state == 'loaded' || state == 'complete' ) ){
            ready_callback.call(this);
        }
        else{
            document.addEventListener("jam_loaded", ready_callback, false);
        }
    }
    
});

(function () {
    Jam.require("bridge");
    Jam.require("ready");
})();
