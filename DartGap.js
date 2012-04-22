// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

DartGap = {};

DartGap.Application = function(messageHandler, messageBuilder) {  
	function log(msg) {
		console.log("\nCORDOVA:> " + msg);
	}

 	function sendMessage(message) {
    	message.target = "Dart";
    	var jsonMessage = JSON.stringify(message);
    	log("sending message " + jsonMessage);
    	window.postMessage(JSON.stringify(message), "*");
  	}

	function receiveMessage(event) {
		var callback, 
        	handler, 
        	message = JSON.parse(event.data);
		
    	if(message.target === "Cordova") {
    		log("got message " + event.data);
      		handler = messageHandler[message.area];
      		if(handler !== undefined) {
        		if(message.callback !== undefined) {
          			callback = function(result) {
         				sendMessage(messageBuilder.callback(message, result)); 
          			}
        		}
        		handler(message, callback);
      		} else {
      			log("unhandled message type " + message.type);
      			throw "unhandled message type " + message.type;
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

  	return {
		"database": function(message, callback) {
		    var db = cache[message.content.connectionId],
		    	executeSql, 
		    	queries, 
		    	queryResult;

		    function getResultCollector(queryNumber) {
		    	var resultCollector = function(tx, resultSet) {
		    		var length = resultSet.rows.length;
		    		var result = {
		    			"query": queries[queryNumber],
		    			"result": new Array(length)
		    		} 
		    		if(length > 0) {
		    			for(var i=0; i<length; i++) {
		    				result["result"][i] = resultSet.rows.item(i)	
		    			}
				    } 

				    queryResult[queryNumber] = result;
				};
				return resultCollector;
			};

			function errorCallback(err) {
    			alert("Error processing SQL: " + err.code);
			};

			function successCallback() {
				callback(queryResult);
			};    
		    
		    switch(message.type) {
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
						queryResult = new Array(queries.length);
						for(var i=0; i < queries.length; i++) {		
							tx.executeSql(queries[i], [], getResultCollector(i), errorCallback); 
						}
					}; 
					db.transaction(executeSql, errorCallback, successCallback);	
			        break;
			    default:
			    	throw "unhandled database message type " + message.type;
		    }
	  	}, 
	  	"device": function(message, callback) {
		    var db, result;
		    switch(message.type) {
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
					db = window.openDatabase(message.content.name, message.content.version, message.content.displayName, message.content.size);
					cache[message.content.connectionId] = db;
			        callback();
			        break;
			    default:
			    	throw "unhandled device message type " + message.type;
		    }
		}, 
	  	"notification": function(message, callback) {
			switch(message.type) {
				case "alert":
			    	navigator.notification.alert(message.content.alert, callback);
			    	break;
			    default:
			    	throw "unhandled notification message type " + message.type;
			}
	  	}
	};
};

// Message builder for outgoing messages to Dart
DartGap.MessageBuilder = function() {
  	return {
	  	"callback": function(message, result) {
	    	var msg = {
		  		"area": message.area + "." + message.type,
		  		"callback": message.callback,
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
