// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _SQLBatchResultImpl implements SQLBatchResult {
  List<SQLResult> results;
  
  _SQLBatchResultImpl(_DeviceMessage message) {
    results = [];
    message.content.forEach((Map data) {
      results.add(new _SQLResultImpl(data["query"], data["result"]));
    });
  }
  
  SQLResult operator[](int index) => results[index];
  
  forEach(f(SQLResult result)) => results.forEach(f);
  
  String toString() => results.toString();
}
