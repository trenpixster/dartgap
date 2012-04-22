// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * The result of running a SQL query
 */ 
interface SQLResult {
  /**
   * The query executed
   */
  String get query();
  
  /**
   * The result set of the query
   */
  List<Map> get result();
  
  /**
   * Convinece function to get entry in SQL result
   */
  Map operator[](int index);
  
  /**
   * Convinece function to loop over each entry in the SQL result
   */
  forEach(f(Map data));
}

