import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewScreen extends StatefulWidget {
  final String url;
  final String orderId;

  const PaymentWebviewScreen({
    super.key,
    required this.url,
    required this.orderId,
  });

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("🌐 WebView started loading: $url");
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            debugPrint("✅ WebView finished loading: $url");
            setState(() => _isLoading = false);

            // Example: detect success/failure
            if (url.contains("success")) {
              debugPrint("🎉 Payment success detected in URL");
              Navigator.of(context).pop(true);
            } else if (url.contains("fail") || url.contains("error")) {
              debugPrint("❌ Payment failed detected in URL");
              Navigator.of(context).pop(false);
            }
          },
          onWebResourceError: (error) {
            debugPrint("🚨 WebView error: ${error.description}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("WebView error: ${error.description}")),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Payment ")),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
