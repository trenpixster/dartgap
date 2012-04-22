#library("qalqo:dartgap:testapp");

#import("dart:html");
#import("../Lib.dart");

main() {
  dartgap.onDeviceReady = ((Device device) {
    _addHtml("<h1>Hey, it's Dart!</h1>");
    
    // database API
    device.openDatabase("testdb", "1.0", "TestDB", 10000).then((DeviceDatabase db) {
      Future<SQLBatchResult> batchCallback = db.batchSql("DROP TABLE IF EXISTS USERS").
         batchSql("CREATE TABLE IF NOT EXISTS USERS (id unique, username unique)").
         batchSql("INSERT INTO USERS (id, username) VALUES (1, 'Bob')").
         batchSql("INSERT INTO USERS (id, username) VALUES (2, 'Seth')").
         batchSql("SELECT * FROM USERS").
         executeBatch(); 
      
      batchCallback.then((SQLBatchResult result) {
        _addHtml("<h2>Dart talked to the Device Database!</h2>");
        result[4].forEach((Map data) {
          String id = data["id"];
          String username = data["username"];
          _addHtml("<p>User ${id}: ${username}</p>");
        });
      });
      batchCallback.handleException((Exception e) => print("error is $e"));
    });
    
    // device API
    device.info.then((DeviceInfo deviceInfo) {
      _addHtml("<h2>Dart got Device Info!</h2>");
      _addHtml("<p>name: ${deviceInfo.name}</p>");
      _addHtml("<p>cordova: ${deviceInfo.cordova}</p>");
      _addHtml("<p>platform: ${deviceInfo.platform}</p>");
      _addHtml("<p>uuid: ${deviceInfo.uuid}</p>");
      _addHtml("<p>version: ${deviceInfo.version}</p>");
    });
   
    // notification API
    device.notification.alert("Dart says hello");
  });
}

_addHtml(String html) {
  document.body.nodes.add(new Element.html(html));
}










