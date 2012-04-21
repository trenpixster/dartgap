// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceNotificationImpl extends _DeviceAware implements DeviceNotification {
  _DeviceNotificationImpl(): super("notification");
  
  Future<Map> alert(String alertMessage) {
    var completer = new Completer<Map>();
    
    var message = createMessage("alert");
    message.content["alert"] = alertMessage;
    message.callback = (_DeviceMessage msg) {
      completer.complete(msg.content);
    };
    sendMessage(message);
    
    return completer.future;
  }
}