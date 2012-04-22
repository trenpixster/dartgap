// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

typedef _DeviceMessageHandler(_DeviceMessage message);

class _DeviceMessageRouter {
  final Map<String, _DeviceMessageAware> _messageHandlers;
  final Map<_Guid, _DeviceMessageHandler> _callbacks;
  final Logger _logger;
  static _DeviceMessageRouter _instance;
  
  factory _DeviceMessageRouter() {
    if(_instance === null) {
      _instance = new _DeviceMessageRouter._internal();
    }
    return _instance;
  }
  
  _DeviceMessageRouter._internal()
    : _messageHandlers = new Map<String, _DeviceMessageAware>(),
      _callbacks = new Map<_Guid, _DeviceMessageHandler>(),
      _logger = LoggerFactory.getLogger("dartgap._DeviceMessageRouter") 
  {
      window.on.message.add(_messageRouter, false); 
  }
 
  _messageRouter(MessageEvent event) {
    var jsonMsg = JSON.parse(event.data);
    if(jsonMsg["target"] == "Dart") {
      var message = new _DeviceMessage.json(jsonMsg);
      _logger.debug("got message of type [${message.type}] for area [${message.area}]");
      if(message.type == "callback") {
        // dart message callback
        var callbackId = new _Guid.fromValue(message.callback);
        _DeviceMessageHandler callback = _callbacks[callbackId];
        Expect.isNotNull(callback);
        
        _logger.debug("executing callback [$callbackId] for area [${message.area}]");
        callback(message);
        _callbacks.remove(callbackId);
      } else {
        // message from device
        _logger.debug("executing handler for area [${message.area}] and type [${message.type}]");
        _DeviceMessageAware handler = _messageHandlers[message.area];
        Expect.isNotNull(handler);
        handler.receiveMessage(message);
      }
    }
  }  
  
  /**
   * Register a message aware handler that revices messages directly from the device
   */
  registerMessageHandler(_DeviceMessageAware messageAware) {
    _messageHandlers[messageAware.area] = messageAware;
  }
  
  /**
   * Send a message to the device
   */
  sendMessage(_DeviceMessage message) {
    if(message.callback !== null) {
      // save callback so we can retrieve it later when a reply occures
      var callbackId = new _Guid();
      _callbacks[callbackId] = message.callback;
      message.callback = callbackId;
    }
    String jsonMessage = message.asJsonString;
    _logger.debug("sending message ${jsonMessage}");
    window.postMessage(jsonMessage, "*"); 
  }
}