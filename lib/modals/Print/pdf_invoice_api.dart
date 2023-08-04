//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:awafi_pos/modals/Print/pdf_api.dart';
import 'package:awafi_pos/modals/Print/supplier.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'Invoice.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    final doc = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {

          return pw.ListView(

            children: [
              buildHeader(invoice),
              SizedBox(height: 1 * PdfPageFormat.cm),
              // buildTitle(invoice),
              buildInvoice(invoice),
              Divider(),
              buildTotal(invoice),
            ],
          );// Center
        }));
    // pdf.addPage(MultiPage(
    //   // pageFormat: PdfPageFormat.roll80,
    //   build: (context) => [
    //     buildHeader(invoice),
    //     SizedBox(height: 3 * PdfPageFormat.cm),
    //     // buildTitle(invoice),
    //     buildInvoice(invoice),
    //     Divider(),
    //     buildTotal(invoice),
    //   ],
    //   footer: (context) => buildFooter(invoice),
    // ));

    print('aaaaaaaaaaaaaaaaaaaaaa');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    return PdfApi.saveDocument(name: 'PerfoPowa-${DateTime.now()}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // buildSupplierAddress(invoice.supplier),
          Column(
            children:[
          Container(
            height: 40,
            width: 40,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: invoice.info.number,
            ),
          ),
              Text('PIZZA ROMA',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold )),
              Text('Jeddah-Azizia',style: TextStyle(fontSize: 10 )),
              Text('Phone : +966 569817181',style: TextStyle(fontSize: 10 )),
              buildInvoiceInfo(invoice.info),
              Text('Table No : ${invoice.table.toString()}',style: TextStyle(
                fontSize: 10
              )),
  ]),
        ],
      ),
      // SizedBox(height: 1 * PdfPageFormat.cm),

    ],
  );



  static Widget buildInvoiceInfo(InvoiceInfo info) {
    // final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Token No:',
      'Bill Date:'
    ];
    final data = <String>[
      info.number,
     info.date==null ?DateTime.now().toLocal().toString().substring(0,19):info.date.toString().substring(0,16),

     
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(
            title: title, value: value, width:  70 * PdfPageFormat.mm);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.address),
    ],
  );

  // static Widget buildTitle(Invoice invoice) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       'INVOICE',
  //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //     ),
  //     SizedBox(height: 0.8 * PdfPageFormat.cm),
  //     Text(invoice.info.description,style: TextStyle(fontSize: 15)),
  //     SizedBox(height: 0.8 * PdfPageFormat.cm),
  //   ],
  // );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Product ',
      'Qty ',
      'Price ',
      'Total'
    ];
    final data = invoice.salesItems.map((customer) {
      final total = customer.price * customer.quantity * (1 + customer.gst/100);
      print(total);

      return [
        customer.description,
        '${customer.quantity}',
        ' ${customer.price}',
        '  ${total.toStringAsFixed(2)}',
      ];
    }
    ).toList();

    return Table.fromTextArray(
      headers: headers,

      data: data,
      border: null,
      headerStyle: TextStyle(fontSize:8,fontWeight: FontWeight.bold),

      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellStyle: TextStyle(fontSize: 8,),
      cellHeight: 25,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,

      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
     double netTotal =0.00;
    double vat=0.00;
    invoice.salesItems
        .map((item) {
          netTotal+=item.price * item.quantity;
          vat+=item.price * item.quantity*item.gst/100;
        }).toList();

    
    final total = netTotal + vat-invoice.discount;


    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Discount',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  value: invoice.discount.toStringAsFixed(2),
                  unite: true,
                ),
                // buildText(
                //   title: 'خصم',
                //   titleStyle: TextStyle(
                //     fontSize: 8,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: invoice.discount.toStringAsFixed(2),
                //   unite: true,
                // ),
                Divider(),
                buildText(
                  title: 'Total amount ',
                  titleStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  value: total.toStringAsFixed(2),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: 'Address', value: invoice.supplier.address),
      SizedBox(height: 1 * PdfPageFormat.mm),
      // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
    ],
  );

  static buildSimpleText({
     String title,
     String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
     String title,
     String value,
    double width = double.infinity,
     TextStyle  titleStyle,
    bool unite = false,
  }) {
     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold, );
     
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}