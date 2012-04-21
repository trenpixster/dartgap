// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * The device object describes the device's hardware and software.
 */
interface Device {
  /**
   * Handler for visual, audible, and tactile device notifications.
   */
  DeviceNotification get notification();
  
  /**
   * Retrieve device information such as platform and version
   */
  Future<DeviceInfo> get info();
  
  /**
   * Returns a Database object for [name] and [version]. Where [displayname] 
   * is a user friendly name required by the user agent and [size] is the 
   * esitmated number of bytes required for the database.
   */
  Future<DeviceDatabase> openDatabase(String name, String version, String displayname, int size);
}


