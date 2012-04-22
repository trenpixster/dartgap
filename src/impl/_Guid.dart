// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * Naive, but usable, implementation of a GUID class. 
 *
 * TODO Delete once a real one is added to dart:core
 */
class _Guid implements Hashable {
  final String value;
  
  factory _Guid() {
    int now = new Date.now().value;
    String guid = "${now}-${(Math.random() * now).toInt()}";
    return new _Guid.fromValue(guid);
  }
  
  _Guid.fromValue(this.value);

  operator ==(_Guid other) {
    if(other === null) return false;
    return value == other.value;
  }
  
  int hashCode() => value.hashCode();
  
  toString() => value;
}
