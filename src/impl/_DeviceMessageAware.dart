// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Base class for classes that handles messages send from the Device to Dart 
 */
class _DeviceMessageAware {
  final _DeviceMessageRouter _router;
  final String area;

  _DeviceMessageAware(this.area): _router = new _DeviceMessageRouter() {
    _router.registerMessageHandler(this);
  }
  
  /**
   * Method invoked when the Device calls Dart directly 
   */
  abstract receiveMessage(_DeviceMessage message);
}





