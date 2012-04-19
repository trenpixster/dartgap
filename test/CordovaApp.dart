#library("qalqo:dartgap:testapp");

#import("dart:html");
#import("dart:json");
#import("../Lib.dart");

main() {
  device.onDeviceReady = () {
    document.body.nodes.add(new Element.html("<h1>Hey, it's Dart!</h1>"));
    
    // device API
    device.info.then((DeviceInfo deviceInfo) {
      document.body.nodes.add(new Element.html("<h1>Dart got Device Info</h1>"));
      document.body.nodes.add(new Element.html("<h2>name: ${deviceInfo.name}</h2>"));
      document.body.nodes.add(new Element.html("<h2>cordova: ${deviceInfo.cordova}</h2>"));
      document.body.nodes.add(new Element.html("<h2>platform: ${deviceInfo.platform}</h2>"));
      document.body.nodes.add(new Element.html("<h2>uuid: ${deviceInfo.uuid}</h2>"));
      document.body.nodes.add(new Element.html("<h2>version: ${deviceInfo.version}</h2>"));
    });
   
    // notification API
    device.notification.alert("Dart says hello").then((Map data) {
      document.body.nodes.add(new Element.html("<h1>Hey, it's a callback from Cordova to Dart!</h1>"));
    });
  };
}










