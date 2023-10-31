import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../model/web_model.dart';

class WebProvider extends ChangeNotifier {
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

  List<WebModel> webSites = [
    WebModel(
      webName: 'UIDAI',
      webURL: 'https://uidai.gov.in',
    ),
    WebModel(
      webName: 'EPFO',
      webURL: 'https://www.epfindia.gov.in/site_en/index.php',
    ),
    WebModel(
      webName: 'Niti-Aayog',
      webURL: 'https://niti.gov.in',
    ),
    WebModel(
      webName: 'PariVahan',
      webURL: 'https://parivahan.gov.in/parivahan',
    ),
  ];

  void initController(controller) {
    inAppWebViewController = controller;
    notifyListeners();
  }

  void initRefresh() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () {
        inAppWebViewController!.reload();
      },
    );
    notifyListeners();
  }

  Future<void> homePage(String uri) async {
    await inAppWebViewController!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(uri),
      ),
    );
    notifyListeners();
  }

  Future<void> refresh() async {
    await inAppWebViewController!.reload();
    notifyListeners();
  }

  Future<void> forward() async {
    if (await inAppWebViewController!.canGoForward()) {
      await inAppWebViewController!.goForward();
    }
    notifyListeners();
  }

  Future<void> back() async {
    if (await inAppWebViewController!.canGoBack()) {
      await inAppWebViewController!.goBack();
      notifyListeners();
    }
  }

  void stopRefresh() {
    pullToRefreshController!.endRefreshing();
    notifyListeners();
  }
}
