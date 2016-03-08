library test_plus.networkinterface;

import 'package:tetorica/net.dart';
import 'package:tetorica/http.dart' as http;
import 'dart:convert' as conv;
import 'package:test/test.dart' as test;

doTest(TetSocketBuilder builder) async {

  test.test("put", () async {
    http.HttpClient client = new http.HttpClient(builder);
    await client.connect("httpbin.org", 80);
    http.HttpClientResponse postResult = await client.put("/put", conv.UTF8.encode(conv.JSON.encode({"message": "hello!!"})), header: {"nono": "nano", "Content-Type": "application/json"});
    print("## ${postResult.message.contentLength}");
    print("## ${await postResult.body.getString()}");
    Map<String, Object> ret = conv.JSON.decode(await postResult.body.getString());
    test.expect("application/json", (ret["headers"] as Map)["Content-Type"]);
    test.expect("nano", (ret["headers"] as Map)["Nono"]);
    test.expect("hello!!", (ret["json"] as Map)["message"]);
  });
}
