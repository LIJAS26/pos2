//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import '../../Branches/branches.dart';
import '../../modals/Print/pdf_api.dart';
import 'dailyReport_model.dart';

var image;


var format = NumberFormat.simpleCurrency(locale: 'en_in');

class B2bPdfInvoiceApi {
  static Future<File> generate(DailyReportData invoice) async {
    final pdf = Document();
    image = await imageFromAssetBundle('assets/faraula_logo.png');

    pdf.addPage(MultiPage(
      build: (context) => [

        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children:[
//START
              pw.Container(
                height: 100,
                width: 100,
                child:pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(image,width: 90,height: 90,fit: pw.BoxFit.contain),
                    ]
                ),
              ),
//STUDENT DETAIL
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [

                    pw.Container(
                      width: 250,
                      // color: PdfColors.green,
                      child:  pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [

                            pw.SizedBox(height: 20),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Shop Name',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': Boofiya Faraula',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),

                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Vat Number',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': $vatNumber',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Starting Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.from)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                                children: [
                                  pw.Container(width: 70,child: pw.Text('Ending Date',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                  pw.Container(width: 170,child: pw.Text(': ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.to)}',style: pw.TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),),
                                ]
                            ),

                          ]
                      ),
                    ),


                  ]
              ),

              pw.SizedBox(height: 30),

//TABLE
              pw.Container(
                child:

                pw.Table(
                    tableWidth: TableWidth.max,
                    border: pw.TableBorder.all(width: 1,color: PdfColors.grey),
                    children: [

                      pw.TableRow(
                          children: [
                            pw.Container(width: 40,child:pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Sl.No',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))))),
                            pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Description',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))))),
                            pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Count',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))))),
                            pw.Expanded(child: pw.Center(child: pw.Padding(padding: pw.EdgeInsets.only(top: 5,bottom: 5),child: pw.Text('Amount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))))),

                          ]
                      ),

                      pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('1.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Sale'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.sale.toStringAsFixed(2)))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.saleAmount.toStringAsFixed(2)))),
                          ]
                      ),
                      pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('2.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Purchase'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.purchase.toStringAsFixed(2)))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.purchaseAmount.toStringAsFixed(2)))),
                          ]
                      ),
                      pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('3.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Expense'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.expense.toStringAsFixed(2)))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.expenseAmount.toStringAsFixed(2)))),
                          ]
                      ),
                      pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('4.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Return'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.rtn.toStringAsFixed(2)))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.rtnAmount.toStringAsFixed(2)))),
                          ]
                      ),pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('4.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('VAT Payable'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(' '))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.vatPayable.toStringAsFixed(2)))),
                          ]
                      ),
                      pw.TableRow(
                          children: [
                            pw.Container(height:30,width: 40,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('5.'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text('Balance'))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(' '))),
                            pw.Container(height:30,child: pw.Padding(padding: pw.EdgeInsets.only(left: 5,top: 10),child: pw.Text(invoice.balance.toStringAsFixed(2)))),
                          ]
                      ),
                    ]
                ),

              ),

              pw.Container(
                height: 30
              ),

              pw.SizedBox(height: 5),
              Text('Staff Data',style: pw.TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              pw.SizedBox(height: 10),


              //table with list.generate

              pw.Container(
                child:  pw.Table.fromTextArray(
                    context: context,
                    headers: [
                      'Name',
                      'Sale',
                      'Cash\n(S)',
                      'Bank\n(S)',
                      'Purchase',
                      'Cash\n(P)',
                      'Bank\n(P)',
                      'Expense',
                      'Cash\n(E)',
                      'Bank\n(E)',
                      'Return',
                    ],

                    data:
                    List.generate(invoice.userSaleData.length, (index) {
                      final item =invoice.userSaleData[index];
                      print(item.toString()+'                    $index');
                      return [
                        item['name'],
                        item['saleAmount'],
                        item['saleAmountCash'],
                        item['saleAmountBank'],
                        item['puchaseAmount'],
                        item['purchaseAmountCash'],
                        item['purchaseAmountBank'],
                        item['expenseAmount'],
                        item['expenseAmountInCash'],
                        item['expenseAmountInBank'],
                        item['returnAmount'],
                      ];
                    })

                ),
              ),

              pw.Container(
                  height: 30
              ),

              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('seal',style: pw.TextStyle(fontSize: 11,)),
                    pw.Container(width: 120,child: pw.Text('Official Signature',style: pw.TextStyle(fontSize: 11,)),)
                  ]
              ),
              pw.SizedBox(height: 30),

            ]
        ),

//END
        pw.Container(
          height: 50,
          width: 700,

        ),
      ],
    ));



    //web
    // final bytes = pdf.save();
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(
    //     await generate());
    // final anchor =
    // html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    // print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android
    return PdfApi.saveDocument(name: '${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.from)} - ${DateFormat("yyyy-MM-dd   hh:mm  aaa").format(invoice.to)}.pdf', pdf: pdf);
  }


}