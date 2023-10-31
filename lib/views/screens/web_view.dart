import 'package:adv_flutter_4pm/model/web_model.dart';
import 'package:adv_flutter_4pm/provider/web_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    super.initState();
    Provider.of<WebProvider>(context, listen: false).initRefresh();
  }

  @override
  Widget build(BuildContext context) {
    WebModel args = ModalRoute.of(context)!.settings.arguments as WebModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.webName),
      ),
      body: InAppWebView(
        pullToRefreshController:
            Provider.of<WebProvider>(context).pullToRefreshController,
        initialUrlRequest: URLRequest(
          url: Uri.parse(args.webURL),
        ),
        onLoadStart: (controller, uri) {
          Provider.of<WebProvider>(context, listen: false)
              .initController(controller);
        },
        onLoadStop: (controller, uri) {
          Provider.of<WebProvider>(context, listen: false).stopRefresh();
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await Provider.of<WebProvider>(context, listen: false).back();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              await Provider.of<WebProvider>(context, listen: false).forward();
            },
            child: const Icon(
              Icons.arrow_forward,
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              await Provider.of<WebProvider>(context, listen: false).refresh();
            },
            child: const Icon(
              Icons.restart_alt,
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              await Provider.of<WebProvider>(context, listen: false)
                  .homePage(args.webURL);
            },
            child: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
    );
  }
}
