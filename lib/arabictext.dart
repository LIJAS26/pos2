//@dart=2.9

import 'package:basic_utils/basic_utils.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class ArabicText extends StatefulWidget {
  const ArabicText({Key key}) : super(key: key);

  @override
  _ArabicTextState createState() => _ArabicTextState();
}


class _ArabicTextState extends State<ArabicText> {

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      print("connect");
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            connected = true;
            pressed = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            connected = false;
            pressed = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      btDevices = devices;
    });
  }
  void arabicTest() async {

    // 2- ESC_ALIGN_RIGHT
    bluetooth.isConnected.then((isConnected) async {
      if (isConnected) {
        String arabic='ﻟﺤﻢ 123 ';

        String arabic1=StringUtils.reverse(arabic);
        bluetooth.printCustom("$arabic1",1,1,charset: "ISO-8859-6");

        bluetooth.paperCut();
      }
    });
    Navigator.pop(context);
  }
  @override
  void initState() {
    super.initState();
    if(!connected){
      initPlatformState();

    }
    else{
      arabicTest();
      // Navigator.pop(context);
    }

    // initSavetoPath1();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
