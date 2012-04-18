// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class Device implements DeviceMessageAware {
  static Device _instance;
  
  // delegates
  final DeviceNotification notification;
  
  // handlers
  var _onDeviceReady;
  
  factory Device() {
    if(_instance === null) {
      _instance = new Device._internal();
    }
    return _instance;
  }
  
  Device._internal()
    : notification = new DeviceNotification() 
  {
    window.on.message.add(_messageDispatcher, false); 
  }
  
  _messageDispatcher(MessageEvent event) {
    var jsonMsg = JSON.parse(event.data);
    if(jsonMsg["target"] == "Dart") {
      var msg = new DeviceMessage.json(jsonMsg);
      switch(msg.area) {
        case "device":
          receiveMessage(msg);
          break;
        default:
          throw "unhandled message area ${msg.area}";
      }
    }
  }
   
  receiveMessage(DeviceMessage message) {
    switch(message.type) {
      case "ready":
        _onDeviceReady();
        break;
      default:
        throw "unhandled message type ${message.type}";
    }
  }
  
  set onDeviceReady(void callback()) => _onDeviceReady = callback;
}
