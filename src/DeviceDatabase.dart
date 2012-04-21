// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Interact with Cordova's WebSQL database
 */
interface DeviceDatabase {
  /**
   * Run a single database query
   */
  Future<SQLResult> executeSql(String sql);
  
  /**
   * Run multiple database queries
   */
  SQLBatch batchSql(String sql);

  /**
   * Atomically verify and update the schema version number
   *
   * The future retuned contains the new version number of the database after the update
   */
  Future<String> changeVersion(String expectedCurrentVersion, String newVersion);
  
  /**
   * Close the database connection
   */
  close();
}
