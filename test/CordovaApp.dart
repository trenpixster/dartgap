#library("qalqo:dartgap:testapp");

#import("dart:html");
#import("../Lib.dart");

main() {
  dartgap.onDeviceReady = ((Device device) {
    _addHtml("<h1>Hey, it's Dart!</h1>");
    
    // device API
    device.info.then((DeviceInfo deviceInfo) {
      _addHtml("<h1>Dart got Device Info</h1>");
      _addHtml("<h2>name: ${deviceInfo.name}</h2>");
      _addHtml("<h2>cordova: ${deviceInfo.cordova}</h2>");
      _addHtml("<h2>platform: ${deviceInfo.platform}</h2>");
      _addHtml("<h2>uuid: ${deviceInfo.uuid}</h2>");
      _addHtml("<h2>version: ${deviceInfo.version}</h2>");
    });
   
    // notification API
    device.notification.alert("Dart says hello").then((Map data) {
      _addHtml("<h1>Hey, it's a callback from Cordova to Dart!</h1>");
    });
    
    // database API
    device.openDatabase("testdb", "1.0", "Dart Cordova Test DB", 10000).then((DeviceDatabase db) {
      SQLBatch batch = db.batchSql("DROP TABLE IF EXISTS USERS").
         batchSql("CREATE TABLE IF NOT EXISTS USERS (id unique, username)").
         batchSql("INSERT INTO USERS (id, username) VALUES (1, 'Bob')").
         batchSql("INSERT INTO USERS (id, username) VALUES (2, 'Seth')").
         batchSql("SELECT * FROM USERS");
      
      Future<SQLBatchResult> batchResult = batch.executeBatch(); 
      batchResult.then((SQLBatchResult result) => print("result is $result"));
      batchResult.handleException((Exception e) => print("error is $e"));
    });
  });
}

_addHtml(String html) {
  document.body.nodes.add(new Element.html(html));
}










