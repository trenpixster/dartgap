// Copyright (c) 2012 Qalqo, all rights reserved.  
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#library("qalqo:dartgap");

#import("dart:html");
#import("dart:json");
#import("../log/Lib.dart");

#source("src/DartGap.dart");
#source("src/Device.dart");
#source("src/DeviceDatabase.dart");
#source("src/DeviceInfo.dart");
#source("src/DeviceNotification.dart");
#source("src/SQLBatch.dart");
#source("src/SQLBatchResult.dart");
#source("src/SQLResult.dart");

#source("src/impl/_DartGapImpl.dart");
#source("src/impl/_DeviceAware.dart");
#source("src/impl/_DeviceDatabaseImpl.dart");
#source("src/impl/_DeviceImpl.dart");
#source("src/impl/_DeviceInfoImpl.dart");
#source("src/impl/_DeviceMessage.dart");
#source("src/impl/_DeviceMessageAware.dart");
#source("src/impl/_DeviceMessageRouter.dart");
#source("src/impl/_DeviceNotificationImpl.dart");
#source("src/impl/_Guid.dart");
#source("src/impl/_SQLBatchImpl.dart");
#source("src/impl/_SQLBatchResultImpl.dart");
#source("src/impl/_SQLResultImpl.dart");

DartGap get dartgap() => new _DartGapImpl();

