// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

DartGap = {};

DartGap.Application = function(messageHandler, messageBuilder) {
  var self = {};
  
  self.go = function() {
    window.addEventListener("message", messageDispatcher, false);
    sendMessage(messageBuilder.device.ready());
  };
  
  function messageDispatcher(event) {
    var callback, 
        handler, 
        msg = JSON.parse(event.data);
        
    if(msg.target === "Cordova") {
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
  
  function sendMessage(msg) {
    msg.target = "Dart";
    console.log("sending message [" + msg.type + "]");
    window.postMessage(JSON.stringify(msg), "*");
  }
  
  return self;
};

// Message handler for incoming messages from Dart
DartGap.MessageHandler = {
  "notification": function(msg, callback) {
	switch(msg.type) {
	  case "alert":
	    navigator.notification.alert(msg.content.alert, callback);
	    break;
	}
  },
  "device": function(msg, callback) {
    var result;
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
    }
  }
};

// Message builder for outgoing messages to Dart
DartGap.MessageBuilder = {
  "device": {
    "ready": function() {
      return {
        "area": "device",
        "type": "ready"
      };
    },
  
  },
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
  }
};

// application entry point
DartGap.init = function() {
  var app = new DartGap.Application(DartGap.MessageHandler, DartGap.MessageBuilder);
  app.go();
};

