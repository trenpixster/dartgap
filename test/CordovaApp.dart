#library("qalqo:dartgap:testapp");

#import("dart:html");
#import("dart:json");
#import("../Lib.dart");

main() {
  device.onDeviceReady = () {
    document.body.nodes.add(new Element.html("<h1>Hey, it's Dart!</h1>"));
    
    device.notification.alert("Dart says hello").then((Map data) {
      document.body.nodes.add(new Element.html("<h1>Hey, it's a callback from Cordova to Dart!</h1>"));
    });
  };
}










