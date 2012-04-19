// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceImpl extends _DeviceMessageAware implements Device {
  static _DeviceImpl _instance;
  
  // delegates
  final DeviceNotification notification;
  
  // handlers
  var _onDeviceReady;
  
  Future<DeviceInfo> get info() {
    var completer = new Completer<DeviceInfo>();
    
    var message = createMessage("info");
    message.callback = (_DeviceMessage msg) {
      var info = new _DeviceInfoImpl(msg.content);
      completer.complete(info);
    };
    sendMessage(message);
    
    return completer.future;
  }
  
  factory _DeviceImpl() {
    if(_instance === null) {
      _instance = new _DeviceImpl._internal();
    }
    return _instance;
  }
  
  _DeviceImpl._internal()
    : super("device"),
      notification = new _DeviceNotificationImpl();
  
  receiveMessage(_DeviceMessage message) {
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

