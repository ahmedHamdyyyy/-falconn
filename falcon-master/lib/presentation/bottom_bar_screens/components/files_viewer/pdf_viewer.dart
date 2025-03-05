import 'dart:async';

import 'package:falcon/core/core_exports.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

/*class PdfViewerPage extends StatefulWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openAsset(widget.pdfPath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey,
      appBar: CustomAppBar(
        context: context,
        hasArrowBack: true,
        elevation: 0  ,
        title: 'Artificial Intelligence Content',
      ),
      body: PdfView(
        scrollDirection: Axis.vertical,
        controller: _pdfController,
      ),
    );
  }
}*/

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
                child: SfPdfViewer.network(
                  '$pdfPath',
                  onDocumentLoadFailed: (PdfDocumentLoadFailedDetails pdfDoc){
                    showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message:"Your file not found or invalid",),);
                    Navigator.pop(context);

                  },
                )),
            TimedWidget(),
          ],
        ));

  }
}

class TimedWidget extends StatefulWidget {
  @override
  _TimedWidgetState createState() => _TimedWidgetState();
}

class _TimedWidgetState extends State<TimedWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // Set a timer for 5 seconds to hide the widget
    Timer(Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: _isVisible,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}