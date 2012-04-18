// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Messages send and recived from Cordova to Dart
 */
class DeviceMessage {
  final String area;
  final String type;
  Map content;
  
  factory DeviceMessage.json(Object data) {
    var json = JSON.parse(data);
    return new DeviceMessage(json["area"], json["type"], json["content"]);
  }
  
  DeviceMessage(this.area, this.type, [this.content = null]) {
    if(content === null) {
      content = {};
    }
  }
  
  // TODO overload [] to extract content
  
  String get asJsonString() {
    var msg = {
      "area": area,
      "type": type,
      "content": content
    };
    return JSON.stringify(msg);
  }
}

/**
 * Implemented by all classes that can handle incoming Cordova messages
 */
interface DeviceMessageAware {
  receiveMessage(DeviceMessage message);
}