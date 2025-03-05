import 'dart:io';

import 'package:falcon/core/core_exports.dart';
import 'package:flutter/services.dart';

class WordViewerPage extends StatelessWidget {
  final String wordPath;

  WordViewerPage({required this.wordPath});

  Future<void> openWordFile(BuildContext context) async {
    final filePath = await _getLocalFile(wordPath);
    OpenFilex.open(filePath.path);
  }

  Future<File> _getLocalFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final buffer = byteData.buffer;

    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/${assetPath.split('/').last}';
    final tempFile = File(tempFilePath);

    await tempFile.writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      flush: true,
    );

    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => openWordFile(context),
          child: Text('Open Word Document'),
        ),
      ),
    );
  }
}
