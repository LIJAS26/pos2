//@dart=2.9
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
     String name,
     Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
// class PdfApi {
//   static Future<File> generateInvoice() async {
//     final pdf = Document();
//
//     return saveDocument(name: 'Invoice.pdf',pdf:pdf);
//   }
//
//   static Future openFile(File file) async {
//     final url = file.path;
//     await OpenFile.open(url);
//   }
//
//   static Future<File> saveDocument({
//     String name, Document pdf
//   }) async{
//     final bytes =await pdf.save();
//     final dir =await getApplicationDocumentsDirectory();
//     await file.writeAsBytes(bytes);
//     return file;
//   }
//
//
// }