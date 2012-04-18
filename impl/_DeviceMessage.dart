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
    return new _DeviceMessage(json["area"], json["type"], json["content"]);
  }
  
  _DeviceMessage(this.area, this.type, [this.content = null]) {
    if(content === null) {
      content = {};
    }
  }
  
  String get asJsonString() {
    var msg = {
      "area": area,
      "callback": callback,
      "content": content,
      "type": type,
      "target": "Cordova"
    };
    return JSON.stringify(msg);
  }
}


