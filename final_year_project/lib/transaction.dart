import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_year_project/models/apikey.dart';
import 'package:final_year_project/models/paystack_response.dart';
import 'package:final_year_project/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    super.key,
    required this.amount,
    required this.email,
    required this.reference,
  });

  final String amount;
  final String email;
  final String reference;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Future<PayStackAuthResponse> createTransaction(
      Transaction transaction) async {
    const String url = 'https://api.paystack.co/transaction/initialize';
    final data = transaction.toJson();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiKey.secretKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print(response.body);
        // Payment initialization successful
        final responseData = jsonDecode(response.body);
        return PayStackAuthResponse.fromJson(responseData['data']);
      } else {
        throw 'Payment unsuceesful';
      }
    } on Exception {
      throw 'Payment Unsuceesful';
    }
  }
  // Future<bool> verifyTransaction(String reference) async {
  //   final String url = 'https://api.paystack.co/transaction/verify/$reference';
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Authorization': 'Bearer ${ApiKey.secretKey}',
  //       'Content-Type': 'application/json'
  //     });
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       if (responseData['data']['gateway_response'] == 'Approved') {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } on Exception {
  //     return false;
  //   }
  // }

  Future<String> initializeTransaction() async {
    try {
      final price = double.parse(widget.amount);
      final transaction = Transaction(
        amount: (price * 100).toString(),
        reference: widget.reference,
        currency: 'GHS',
        email: widget.email,
      );

      final authResponse = await createTransaction(transaction);
      return authResponse.authorization_url;
    } catch (e) {
      print('Error initializing transaction: $e');
      return e.toString();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: initializeTransaction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final url = snapshot.data;
            return WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) {
                      if (request.url.startsWith('https://www.youtube.com/')) {
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(url!)),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }
}
