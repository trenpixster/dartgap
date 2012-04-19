// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class _DeviceInfoImpl implements DeviceInfo {
  final String name;
  final String cordova;
  final String platform;
  final String uuid;
  final String version;
  
  factory _DeviceInfoImpl(Map data) {
    return new _DeviceInfoImpl._internal(data["name"], data["cordova"], data["platform"], data["uuid"], data["version"]);
  }
  
  _DeviceInfoImpl._internal(this.name, this.cordova, this.platform, this.uuid, this.version);
}
