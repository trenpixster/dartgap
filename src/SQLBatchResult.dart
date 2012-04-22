// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * The result of running a batch of SQL queries
 */ 
interface SQLBatchResult {
  List<SQLResult> get results();
  
  /**
   * Convinece function to get entry in batch result
   */
  SQLResult operator[](int index);
  
  /**
   * Convinece function to loop over each entry in the batch result
   */
  forEach(f(SQLResult result));
}
