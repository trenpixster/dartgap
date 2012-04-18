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
    var msg = JSON.parse(event.data);
    if(msg.target == "Cordova") {
      var handler = messageHandler[msg.area];
      if(handler !== undefined) {
        var callback = function() {
          if(msg.callback !== undefined) {
          	sendMessage(messageBuilder.callback(msg)); 
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
      switch (msg.type) {
        case "alert":
          navigator.notification.alert(msg.content.alert, callback);
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
    }
  },
  "callback": function(msg) {
    return {
	  "area": msg.area + "." + msg.type,
	  "callback": msg.callback,
	  "content": msg.content,
	  "type": "callback"
	};
  }
};

// application entry point
DartGap.init = function() {
  var app = new DartGap.Application(DartGap.MessageHandler, DartGap.MessageBuilder);
  app.go();
};

