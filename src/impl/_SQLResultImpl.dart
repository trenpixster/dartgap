// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _SQLResultImpl implements SQLResult {
  final String query;
  final List<Map> result;
  
  _SQLResultImpl(this.query, this.result);
  
  Map operator[](int index) => result[index];
  
  forEach(f(Map data)) => result.forEach(f);
  
  String toString() => "query: [$query] result [${result.toString()}]";
}
