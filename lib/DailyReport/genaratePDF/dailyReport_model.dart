//@dart=2.9

import 'package:awafi_pos/backend/backend.dart';

class DailyReportData {


  final double purchaseAmount;
  final double expenseAmount;
  final double saleAmount;
  final double balance;
  final double sale;
  final double purchase;
  final double expense;
  final double rtnAmount;
  final int rtn;
  final List userSaleData;

final double vatPayable;

 final DateTime from;
  final DateTime to;

  const DailyReportData(  {
    this.from,
    this.to,
    this.purchaseAmount,
    this.expenseAmount,
    this.saleAmount,
    this.balance,
    this.sale,
    this.purchase,
    this.expense,
    this.rtn,
    this.rtnAmount,
    this.userSaleData,
    this.vatPayable,
  });
}




