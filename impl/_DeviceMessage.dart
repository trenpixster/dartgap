// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Messages send and recived from Cordova to Dart
 */
class _DeviceMessage {
  final String area;
  final String type;
  var callback;
  Map content;
  
  factory _DeviceMessage.json(var json) {
    return new _DeviceMessage(json["area"], json["type"], json["content"], json["callback"]);
  }
  
  _DeviceMessage(this.area, this.type, [this.content = null, this.callback = null]) {
    if(content === null) {
      content = {};
    }
  }
  
  String get asJsonString() {
    // required keys
    var msg = {
      "area": area,
      "content": content,
      "type": type,
      "target": "Cordova"
    };
    // optional keys
    if(callback !== null) {
      msg["callback"] = callback;
    }
    return JSON.stringify(msg);
  }
}

typedef _DeviceMessageHandler(_DeviceMessage message);


