import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:html' as html;

class HomeViewModel extends ChangeNotifier {
  bool _showWebView = false;
  String _webViewUrl = '';
  String _webViewTitle = '';
  WebViewController? _webViewController;
  bool _isWebViewLoading = true;

  bool get showWebView => _showWebView;
  String get webViewUrl => _webViewUrl;
  String get webViewTitle => _webViewTitle;
  WebViewController? get webViewController => _webViewController;
  bool get isWebViewLoading => _isWebViewLoading;

  void openWebView(String url, String title) {
    if (kIsWeb) {
      _openInNewTab(url);
      return;
    }

    _showWebView = true;
    _webViewUrl = url;
    _webViewTitle = title;
    _isWebViewLoading = true;

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            _isWebViewLoading = true;
            notifyListeners();
          },
          onPageFinished: (String url) {
            _isWebViewLoading = false;
            notifyListeners();
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Erro na WebView: ${error.description}');
            _isWebViewLoading = false;
            notifyListeners();
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    notifyListeners();
  }

  void _openInNewTab(String url) {
    if (kIsWeb) {
      try {
        html.window.open(url, '_blank');
        debugPrint('URL aberta em nova aba: $url');
      } catch (e) {
        debugPrint('Erro ao abrir URL em nova aba: $e');
      }
    }
  }

  void closeWebView() {
    _showWebView = false;
    _webViewUrl = '';
    _webViewTitle = '';
    _webViewController = null;
    _isWebViewLoading = true;
    notifyListeners();
  }

  void goToHome() {
    if (_showWebView) {
      closeWebView();
    }
  }

  void openAutoInsurance() {
    openWebView(
      'https://jsonplaceholder.typicode.com/',
      'Seguro Automóvel',
    );
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }
}
