// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Visual, audible, and tactile device notifications.
 */
interface DeviceNotification {
  /**
   * Shows a custom alert or dialog box.
   */
  Future<Map> alert(String alertMessage, [var callback]);
}