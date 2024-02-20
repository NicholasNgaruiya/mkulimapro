import 'package:flutter/material.dart';

import '../../model/course.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MPChatBot extends StatefulWidget {
  const MPChatBot({super.key, required this.url});
  final String url;
  @override
  State<MPChatBot> createState() => _MPChatBotState();
}

class _MPChatBotState extends State<MPChatBot> {
  late WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent("random")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url!=widget.url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: WebViewWidget(controller: controller,),
      ),
    );
  }
}
