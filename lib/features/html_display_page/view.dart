import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

class HtmlDisplayPagePage extends StatelessWidget {
  // final controller = Get.put(HtmlDisplayPageController());
  final String title;
  final String content;

  const HtmlDisplayPagePage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      // body: SingleChildScrollView(
      //   child: Html(data: content),
      // ),
    );
  }
}
