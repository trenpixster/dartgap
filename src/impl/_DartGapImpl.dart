// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DartGapImpl extends _DeviceMessageAware implements DartGap {
  static _DartGapImpl _instance;
  var _onDeviceReady;
  
  factory _DartGapImpl() {
    if(_instance === null) {
      _instance = new _DartGapImpl._internal();
    }
    return _instance;
  }
  
  _DartGapImpl._internal(): super("dartgap");
  
  receiveMessage(_DeviceMessage message) {
    switch(message.type) {
      case "ready":
        Device device = new _DeviceImpl();
        _onDeviceReady(device);
        break;
      default:
        throw "unhandled message type ${message.type}";
    }
  }
  
  set onDeviceReady(void callback(Device device)) => _onDeviceReady = callback;
}
