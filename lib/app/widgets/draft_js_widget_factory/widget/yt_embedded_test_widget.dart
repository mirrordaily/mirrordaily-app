import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeEmbedPage extends StatefulWidget {
  final String iframeCode;
  final double width;
  final double height;

  const YouTubeEmbedPage({
    super.key,
    required this.iframeCode,
    required this.width,
    required this.height,
  });

  @override
  State<YouTubeEmbedPage> createState() => _YouTubeEmbedPageState();
}

class _YouTubeEmbedPageState extends State<YouTubeEmbedPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final String? src = _extractYouTubeSrc(widget.iframeCode);

    final htmlContent = '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body, html {
              margin: 0;
              padding: 0;
              background-color: black;
              overflow: hidden;
            }
            .video-container {
              width: ${widget.width}px;
              height: ${widget.height}px;
            }
            .video-container iframe {
              width: 100%;
              height: 100%;
              border: none;
            }
          </style>
        </head>
        <body>
          <div class="video-container">
            <iframe
              src="$src"
              title="YouTube video player"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              allowfullscreen>
            </iframe>
          </div>
        </body>
      </html>
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // 讓影片置中
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  String? _extractYouTubeSrc(String iframeCode) {
    final regex = RegExp(r'src="([^"]+)"');
    final match = regex.firstMatch(iframeCode);
    return match?.group(1);
  }
}