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
  String query;
  
  /**
   * The result set of the query
   */
  List<Dynamic> asList;
  
  /**
   * Convert the result into an object by passing in a [resultMapper]
   */
  Dynamic asObject(Dynamic resultMapper(List<Dynamic> list));
}

