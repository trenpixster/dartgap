// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * The device object describes the device's hardware and software.
 */
interface Device {
  /**
   * Fired when cordova is ready to interact with Dart
   */
  set onDeviceReady(void callback());
  
  /**
   * Handler for visual, audible, and tactile device notifications.
   */
  DeviceNotification get notification();
  
  /**
   * Retrieve device information such as platform and version
   */
  Future<DeviceInfo> get info();
}


