// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintingScreen extends StatelessWidget {
  const PrintingScreen(this.title, {Key? key, required this.page})
      : super(key: key);

  final String title;
  final Future<pw.Widget> page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        pageFormats: const {
          "A3": PdfPageFormat.a3,
          "A4": PdfPageFormat.a4,
          "Letter": PdfPageFormat.letter,
        },
        padding: EdgeInsets.all(AppSize.s3),
        initialPageFormat: PdfPageFormat.a3,
        canDebug: false,
        build: (format) => _generatePdf(format, title),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final font = await PdfGoogleFonts.cairoRegular();
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
      theme: pw.ThemeData(
        textAlign: pw.TextAlign.center,
        defaultTextStyle: pw.TextStyle(
          font: font,
          fontSize: 8,
        ),
      ),
    );

    final screen = await page;
    pdf.addPage(
      pw.MultiPage(
        // orientation: pw.PageOrientation.landscape,
        textDirection: pw.TextDirection.rtl,
        pageFormat: format,
        build: (context) {
          return [
            pw.Padding(
              padding: pw.EdgeInsets.all(AppSize.s3),
              child: screen,
            ),
          ];
        },
      ),
    );

    return await pdf.save();
  }
}
