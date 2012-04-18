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
        handler(msg);
      }
    }
  } 
  
  function sendMessage(msg) {
    msg.target = "Dart";
    window.postMessage(JSON.stringify(msg), "*");
  }
  
  return self;
};

// Message handler for incoming messages (dart -> cordova)
DartGap.MessageHandler = {
  "notification": function(msg) {
      switch (msg.type) {
        case "alert":
          navigator.notification.alert(msg.content.alert);
          break;
      }
  }
};

// Message builder for outgoing messages (cordova -> dart)
DartGap.MessageBuilder = {
  "device": {
    "ready": function() {
      return {
        "area": "device",
        "type": "ready"
      };
    }
  }
};

// application entry point
DartGap.init = function() {
  var app = new DartGap.Application(DartGap.MessageHandler, DartGap.MessageBuilder);
  app.go();
};

