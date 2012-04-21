// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _SQLBatchImpl implements SQLBatch {
  final List<String> _queries;
  final BatchExecutor _executor;

  _SQLBatchImpl(this._executor): _queries = new List<String>();
  
  SQLBatch batchSql(String sql) {
    _queries.add(sql);
    return this;
  }
  
  Future<SQLBatchResult> executeBatch() => _executor(_queries);
}

typedef Future<SQLBatchResult> BatchExecutor(List<String> queries);