// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#library("qalqo:dartgap");

#import("dart:html");
#import("dart:json");

#source("impl/_DeviceImpl.dart");
#source("impl/_DeviceMessage.dart");
#source("impl/_DeviceMessageAware.dart");
#source("impl/_DeviceNotificationImpl.dart");

#source("Device.dart");
#source("DeviceNotification.dart");

Device get device() => new _DeviceImpl();

