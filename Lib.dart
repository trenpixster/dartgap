// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#library("qalqo:dartgap");

#import("dart:html");
#import("dart:json");

#source("Device.dart");
#source("DeviceMessage.dart");
#source("DeviceNotification.dart");

Device get device() => new Device();