DartGap: A Dart wrapper for Cordova
===================================

DartGap allows you to use Dart to implement mobile applications using
Apache Cordova (formerly PhoneGap). 

Currently DartGap its more a proof of concept rather than a production ready wrapper of the full Cordova 1.6 API but
the idea is to implement all of it. So if you find something missing then grab the keyboard and send us a pull request.

Getting started
---------------

To use DartGap grab the following code from GitHub

 * ```git clone https://github.com/Qalqo/dartgap```
 * ```git clone https://github.com/Qalqo/log4dart```
 * ```mv log4dart log```

Then import dartgap/Lib.dart into your Dart code and then start
interacting with Cordova via

```
dartgap.onDeviceReady((Device device) {
  device.notification.alert("hello from Dart");
});
```

Also checkout the iOS example below

Getting started on iOS
----------------------

1. Install the latest Cordova and create a sample application by following [this guide][ios]
1. Copy the **test/iOS/index.html** file from **DartGap** into your projects **www** folder.
1. Compile **test/CordovaApp.dart** with **frogc** and copy **CordovaApp.dart.js** to the projects **www** folder
1. Copy **DartGap.js** to your projects **www** folder.
1. Launch iOS Simulator from XCode.

If you change the Dart code in the application remember to recompile and copy it to the **www** folder again. 
Then restart the iOS simulator.

Cordova API status
------------------

* Accelerometer
* Camera
* Capture
* Compass
* Connection
* Contacts
* Device: Fully implemented
* Events
* File
* Geolocation
* Media
* Notification: Work started
* Storage: Work started


TODO
----
* Implement more of the Cordova API http://docs.phonegap.com/en/edge/index.html
* publish API documentation on GitHub

[ios]: http://wiki.phonegap.com/w/page/52010495/Getting%20Started%20with%20PhoneGap-Cordova%20and%20Xcode%204
