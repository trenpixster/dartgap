// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceDatabaseImpl extends _DeviceAware implements DeviceDatabase {
  _Guid _connectionId;
  
  _DeviceDatabaseImpl(this._connectionId): super("database"); 
  
  Future<SQLResult> executeSql(String sql) {
    var completer = new Completer<SQLResult>();
    
    // single queries are executed as a batch with one query inside
    SQLBatch batch = batchSql(sql);
    Future<SQLBatchResult> batchCallback = batch.executeBatch();
    batchCallback.then((SQLBatchResult result) => completer.complete(result[0]));
    batchCallback.handleException((Exception e) => completer.completeException(e));
    
    return completer.future;
  }
  
  SQLBatch batchSql(String sql) {
    SQLBatch batch = new _SQLBatchImpl(_batchExecutor);
    batch.batchSql(sql);
    return batch;
  }

  Future<String> changeVersion(String expectedCurrentVersion, String newVersion) {
    _checkConnection();
    var completer = new Completer();
    
    var message = _connectionMessage("changeVersion");
    message.content["expectedCurrentVersion"] = expectedCurrentVersion;
    message.content["newVersion"] = newVersion;
    message.callback = (_DeviceMessage msg) {
      if(msg.hasErrors) {
        completer.completeException(msg.error);
      } else {
        completer.complete(newVersion);
      }
    };
    sendMessage(message);
    
    return completer.future;
  }
  
  close() {
    _checkConnection();
    var message = _connectionMessage("closeDatabase");
    message.callback = (_DeviceMessage msg) => _connectionId = null;
    sendMessage(message);
  }
  
  Future<SQLBatchResult> _batchExecutor(List<String> queries) {
    _checkConnection();
    var completer = new Completer<SQLBatchResult>();
    
    var message = _connectionMessage("executeBatch");
    message.content["queries"] = queries;
    message.callback = (_DeviceMessage msg) {
      if(msg.hasErrors) {
        completer.completeException(msg.error);
      } else {
        var result = new _SQLBatchResultImpl(msg);
        completer.complete(result);
      }
    };
    sendMessage(message);
    
    return completer.future;
  } 
  
  _checkConnection() => Expect.isNotNull(_connectionId, "Database connection is closed and cannot be used");
  
  _connectionMessage(String type) {
    var message = createMessage(type);
    message.content["connectionId"] = _connectionId.toString();
    return message;
  }
}
