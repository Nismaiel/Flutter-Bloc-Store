import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  requestPayment(String orderId, double amount) async {
    try {
      var request = BraintreeDropInRequest(
          cardEnabled: true, clientToken: 'sandbox_w3pzgckp_v67228vn6pk3qfmw',collectDeviceData: true,
          tokenizationKey: 'sandbox_w3pzgckp_v67228vn6pk3qfmw',
          paypalRequest: BraintreePayPalRequest(
            amount: amount.toString(), currencyCode: 'USD',
            displayName: "Nader ismaiel",));
      BraintreeDropInResult? result = await BraintreeDropIn.start(request);
      if (result != null) {
        print(result.paymentMethodNonce.description);
        //send it to server to make payment
        print(result.paymentMethodNonce.nonce);
        serverCall(result);
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }


  serverCall(BraintreeDropInResult result) async {
    const url = '';
    try {
      final http.Response response = await http.post(Uri.parse(
          '$url?payment_method_nonce=${result.paymentMethodNonce
              .nonce}&device_data=${result.deviceData}'));
    } catch (e) {
      print(e.toString());
    }
  }

}
