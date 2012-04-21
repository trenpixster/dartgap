// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Entry point for DartGap
 */
interface DartGap {
  /**
   * Fired when cordova is ready to interact with Dart
   */
  set onDeviceReady(void callback(Device device));
}
