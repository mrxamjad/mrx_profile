import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class UrlToFile{

  static Future UrlToPdf(
      String url,
      ) async {
    PDFDocument? document;
    document = await PDFDocument.fromURL(url);
    return document;
  }
}