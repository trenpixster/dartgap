// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Base class for all classes that needs to send messages to Cordova
 */
class _DeviceAware {
  final _DeviceMessageRouter _router;
  final String area;

  /**
   * [area] is the area of cordova that the class handles, i.e. notifications, storage, ...
   */
  _DeviceAware(this.area): _router = new _DeviceMessageRouter();
  
  /**
   * Send a message to the device
   */
  sendMessage(_DeviceMessage message) => _router.sendMessage(message);
  
  /**
   * Create a message, to send to the device later, tailored for this area
   */
  _DeviceMessage createMessage(String type) => new _DeviceMessage(area, type);
}
