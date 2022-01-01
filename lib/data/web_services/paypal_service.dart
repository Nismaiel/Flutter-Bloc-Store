import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'AcWZY5FlC7irxXeRWDw8tHP58juX5133L--Z8BcivKxuxAh7NQw7Vw883nAN-Y8fdJ7Wv26874t-GEuw';
  String secret = 'EGAt6qa1avrwRB7WQQx8fEyyXHpglU9rys6444tI7qDEoW9yzIlUmmRE1mofY9BHkch7kAOEKZEMOwnT';

  // for getting the access token from Paypal
  Future getAccessToken() async {
    final url='$domain/v1/oauth2/token?grant_type=client_credentials';
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future createPaypalPayment(
      transactions, accessToken) async {
    final String  url='$domain/v1/payments/payment';
    try {
      var response = await http.post(Uri.parse(url),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
    } catch (e) {
      rethrow;
    }
  }
}