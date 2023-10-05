import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRShareScreen extends StatelessWidget {
  const QRShareScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("Compartir"),),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.wechat_sharp)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.facebook)),
            ],
          ),
        ],
      ),
    );
  }
}
