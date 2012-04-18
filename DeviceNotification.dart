// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class DeviceNotification {
  alert(String alertMessage) {
    var msg = new DeviceMessage("notification", "alert");
    msg.content["alert"] = alertMessage;
    window.postMessage(msg.asJsonString, '*');
  }
}