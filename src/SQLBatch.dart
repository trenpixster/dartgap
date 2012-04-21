// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

interface SQLBatch {
  /**
   * Batch SQL commands to run against database
   */
  SQLBatch batchSql(String sql);
  
  /**
   * Execute all SQL commands in batch and return their result
   */
  Future<SQLBatchResult> executeBatch();
}
