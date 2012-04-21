// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

DartGap = {};

DartGap.Application = function(messageHandler, messageBuilder) {  
 	function sendMessage(msg) {
    	msg.target = "Dart";
    	console.log("sending message of type [" + msg.type + "] to area [" + msg.area + "]");
    	window.postMessage(JSON.stringify(msg), "*");
  	}

	function receiveMessage(event) {
		var callback, 
        	handler, 
        	msg = JSON.parse(event.data);
		
    	if(msg.target === "Cordova") {
    		console.log("got message of type [" + msg.type + "] for area [" + msg.area + "]");
      		handler = messageHandler[msg.area];
      		if(handler !== undefined) {
        		if(msg.callback !== undefined) {
          			callback = function(result) {
            			console.log("callback result from " + msg.type);
            			console.log(result);
         				sendMessage(messageBuilder.callback(msg, result)); 
          			}
        		}
        		handler(msg, callback);
      		}
    	}
	} 

	return {
		"go": function() {
			window.addEventListener("message", receiveMessage, false); 
    		sendMessage(messageBuilder.dartgap.ready());
  		}
	};
};

// Message handler for incoming messages from Dart
DartGap.MessageHandler = function() {
	var cache = {};

	function errorCB(err) {
    	alert("Error processing SQL: "+err.code);
	}

  	return {
		"database": function(msg, callback) {
		    var executeSql, 
		    	db = cache[message.content.connectionId],
		    	queries
		    
		    switch(msg.type) {
		    	case "changeVersion":
		    		db.changeVersion(message.content.expectedCurrentVersion, message.content.newVersion);
		    		callback();
    				break;
    			case "closeDatabase":
    				delete cache[message.content.connectionId];
    				callback();
    				break;
		    	case "executeBatch": 
					executeSql = function(tx) {
						queries = message.content["queries"];
						for(var i=0; i < queries.length; i++) {
							tx.executeSql(queries[i]); 
						}
					};     
					db.transaction(execute, errorCB, callback);	
			        break;
			  	case "executeSql": 
					executeSql = function(tx) {
    					tx.executeSql(message.content.sql);
					};     
					db.transaction(execute, errorCB, callback);	
			        break;
		    }
	  	}, 
	  	"device": function(msg, callback) {
		    var db, result;
		    switch(msg.type) {
			  	case "info": 
				    result = {
			          	"name": device.name,    
			    	  	"cordova": device.cordova,
			    	  	"platform": device.platform, 
			    	  	"uuid": device.uuid,    
			    	  	"version": device.version 
			        };
			        callback(result);
			        break;
				case "openDatabase": 
					db = window.openDatabase(message.content.name, message.content.version, message.content.displayName, parseInt(message.content.size));
					cache[message.content.connectionId] = db;
			        callback();
			        break;
		    }
		}, 
	  	"notification": function(msg, callback) {
			switch(msg.type) {
				case "alert":
			    	navigator.notification.alert(msg.content.alert, callback);
			    	break;
			}
	  	}
	};
};

// Message builder for outgoing messages to Dart
DartGap.MessageBuilder = function() {
  	return {
	  	"callback": function(msg, result) {
	    	var msg = {
		  		"area": msg.area + "." + msg.type,
		  		"callback": msg.callback,
		  		"type": "callback"
		 	};
		 	if(result !== undefined) {
		   		msg.content = result;
		 	}
		 	return msg; 
	  	},
	  	"dartgap": {
	    	"ready": function() {
	      		return {
	        		"area": "dartgap",
	        		"type": "ready"
	      		};
	    	}
		}
	};
};

// application entry point
DartGap.init = function() {
	var messageHandler = new DartGap.MessageHandler();
	var messageBuilder = new DartGap.MessageBuilder();
  	var app = new DartGap.Application(messageHandler, messageBuilder);
  	app.go();
};
