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
  Map content;
  var callback, error;
  
  factory _DeviceMessage.json(var json) {
    var message = new _DeviceMessage(json["area"], json["type"]);
    message.content = json["content"];
    message.callback = json["callback"];
    message.error = json["error"];
    
    return message;
  }
  
  _DeviceMessage(this.area, this.type) {
    content = {};
  }
  
  String get asJsonString() {
    // required keys
    var msg = {
      "area": area,
      "type": type,
      "target": "Cordova",
      "content": content
    };
    // optional keys
    if(callback !== null) {
      msg["callback"] = callback.toString();
    }
    return JSON.stringify(msg);
  }
  
  bool get hasErrors() => error !== null;
}



