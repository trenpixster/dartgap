// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _SQLBatchResultImpl implements SQLBatchResult {
  Map _data;
  
  _SQLBatchResultImpl(_DeviceMessage message) {
    _data = message.content;
  }
  
  String toString() => _data.toString();
}
