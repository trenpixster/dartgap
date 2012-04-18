// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceNotificationImpl extends _DeviceMessageAware implements DeviceNotification {
  _DeviceNotificationImpl(): super("notification");
  
  alert(String alertMessage, [var callback = null]) {
    var msg = createMessage("alert");
    msg.content["alert"] = alertMessage;
    msg.callback = callback;
    sendMessage(msg);
  }
  
  receiveMessage(_DeviceMessage message) { 
    
  }
}