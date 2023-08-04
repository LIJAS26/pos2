//@dart=2.9

import 'package:awafi_pos/modals/Print/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final List<InvoiceItem> salesItems ;
  final double discount;
  final double delivery;
  final int table;

  const Invoice({
     this.info,
     this.table,
     this.supplier,
    this.salesItems,
    this.discount,
    this.delivery
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;

  const InvoiceInfo({
     this.description,
     this.number,
     this.date,

  });
}

class InvoiceItem {
  final String description;
  final double quantity;
  final double tax;
  final double gst;
  final double price;
  final double total;

  const InvoiceItem(
   {
     this.tax,
     this.description,
     this.quantity,
     this.gst,
     this.price,
    this.total, int hsncode,
  });
}