// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceMessageAware {
  static Map _callbacks;
  static Map _messageHandlers;
  String area;
  
  _DeviceMessageAware(this.area) {
    if(_callbacks === null) {
      _callbacks = {};
      _messageHandlers = {};
      window.on.message.add(_messageDispatcher, false); 
    }
    _messageHandlers[area] = this.receiveMessage; 
  }
  
  _messageDispatcher(MessageEvent event) {
    var jsonMsg = JSON.parse(event.data);
    print("got message [${jsonMsg['type']}] target [${jsonMsg['target']}]");
    if(jsonMsg["target"] == "Dart") {
      var message = new _DeviceMessage.json(jsonMsg);
      if(message.type == "callback") {
        // message callback
        var callbackId = message.callback;
        print("handling callback $callbackId");
        _callbacks[callbackId](message);
        _callbacks.remove(callbackId);
      } else {
        // let area specific message handles do the processing
        var handler = _messageHandlers[message.area];
        handler(message);
      }
    }
  }
  
  abstract receiveMessage(_DeviceMessage message);
  
  sendMessage(_DeviceMessage message) {
    if(message.callback !== null) {
      // save callback so we can retrieve it later when a reply occures
      var guid = "${new Date.now().value}-${Math.random()}";
      _callbacks[guid] = message.callback;
      message.callback = guid;
    }
    window.postMessage(message.asJsonString, '*'); 
  }
  
  _DeviceMessage createMessage(String type) => new _DeviceMessage(area, type);
}

