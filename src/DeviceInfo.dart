// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Device information such as platform and version
 */
interface DeviceInfo {
  /**
   * Get the device's model name.
   */
  String get name();
  
  /** 
   * Get the version of Cordova running on the device.
   */
  String get cordova();
  
  /**
   * Get the device's operating system name.
   */
  String get platform();
  
  /**
   * Get the device's Universally Unique Identifier
   */
  String get uuid();
  
  /**
   * Get the operating system version.
   */
  String get version();
}
