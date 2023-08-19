// @dart=2.9
import 'dart:collection';
import 'dart:convert';
import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/services/userService.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'Branches/branches.dart';
import 'flutter_flow/upload_media.dart';
import 'main.dart';



class Login extends StatefulWidget {

  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController userName;
  TextEditingController passWord;
  bool passwordVisibility;

  @override
  void initState() {
    // _getDevicelist();
    // testPrint();
    super.initState();
    // userName = TextEditingController();
    // passWord = TextEditingController();

    userName = TextEditingController(text: 'firstlogic@gmail.com');
    passWord = TextEditingController(text: "123456");
    passwordVisibility = false;

  }

  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();
    for (dynamic device in results) {
      _connect(int.parse(device['vendorId']), int.parse(device['productId']));
    }
    if (mounted) {
      setState(() {
        devices = results;
      }
      );
    }
  }
  _connect(int vendorId, int productId) async {
    bool returned;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if (returned) {
      setState(() {
        connected = true;
      });
    }
  }
  // testPrint() async {
  //   while(!connected){
  //     await Future.delayed(Duration(seconds: 1));
  //     print("while");
  //   }
  //   final CapabilityProfile profile = await CapabilityProfile.load(
  //     // name: "TP806L"
  //          );
  //   Utf8Codec utf8codec=const Utf8Codec(allowMalformed: true);
  //
  //
  //   final generator = Generator(PaperSize.mm80, profile,
  //       codec:utf8codec
  //   );
  //
  //   List<int> bytes = [];
  //   List<int> utf8Bytes = utf8.encode('منتج');
  //   String arabicText = 'منتج';
  //
  //
  //   bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC864(Arabic)'));
  //   bytes += generator.text('منتج', styles: PosStyles(codeTable: '(Arabic)'));
  //   bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC1001'));
  //   bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC1001(Arabic)'));
  //   bytes += generator.text(arabicText, styles: PosStyles(codeTable: 'CP1256'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC863'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC865'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC857'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC737'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'ISO8859-7'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'WPC1252'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC866'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC852'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC858'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'KU42'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC857'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC720'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'PC864'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'WPC1256'));
  //   // bytes += generator.text('منتج', styles: PosStyles(codeTable: 'ISO-8859-6'));
  //
  //   // String arabicText = 'منتج';
  //   // // List<int> pc864Bytes = latin1.encode(arabicText); // Use PC864 encoding
  //   // List<int> pc1001Bytes = utf8.encode(arabicText);  // Use PC1001 encoding
  //   //
  //   //
  //   // // bytes += generator.textEncoded(pc864Bytes, styles: PosStyles(codeTable: 'PC864'));
  //   // // Or use PC1001 encoding
  //   //  bytes += generator.textEncoded(pc1001Bytes, styles: PosStyles(codeTable: 'PC1001'));
  //
  //   // bytes += generator.text(,
  //   //     styles: PosStyles(codeTable: "PC864"));
  //   bytes += generator.feed(2);
  //   bytes += generator.cut();
  //   await flutterUsbPrinter.write(Uint8List.fromList(bytes));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/faraula_background.png"),fit: BoxFit.cover
            )
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.45,

              ),
              Expanded(
                child: Container(
                  child:  Container(

                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height:MediaQuery.of(context).size.height,
                          width: double.infinity,

                          padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(height: 130,width: 350,),

                              const SizedBox(height: 10,),
                              Expanded(
                                child: Container(
                                 margin: const EdgeInsets.only(left: 30,right: 30),
                                  padding: const EdgeInsets.only(left: 30,right: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      //BoxShadow
                                    ],
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            height: 150,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/faraula_logo.png")
                                              )
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.black,

                                                ),
                                              ),

                                              Expanded(
                                                child: TextFormField(
                                                  controller: userName,
                                                  obscureText: false,
                                                  keyboardType: TextInputType.emailAddress,
                                                  decoration: InputDecoration(
                                                    hintText: 'Username/Email/Phone',
                                                    hintStyle:
                                                    TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.grey.shade500,
                                                    ),
                                                    enabledBorder: const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(4.0),
                                                        topRight: Radius.circular(4.0),
                                                      ),
                                                    ),
                                                    focusedBorder: const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(4.0),
                                                        topRight: Radius.circular(4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style:
                                                  const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.01),

                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: secondaryColor)
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                child: Icon(
                                                  Icons.lock,
                                                  color:Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: passWord,
                                                  obscureText: !passwordVisibility,
                                                  decoration: InputDecoration(
                                                    hintText: 'Password',
                                                    hintStyle:
                                                    TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.grey.shade500,
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(4.0),
                                                        topRight: Radius.circular(4.0),
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(4.0),
                                                        topRight: Radius.circular(4.0),
                                                      ),
                                                    ),
                                                    suffixIcon: InkWell(
                                                      onTap: () => setState(
                                                            () => passwordVisibility =
                                                        !passwordVisibility,
                                                      ),
                                                      child: Icon(
                                                        passwordVisibility
                                                            ? Icons.visibility_outlined
                                                            : Icons.visibility_off_outlined,
                                                        color: Colors.black,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                  style:
                                                  TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                              child: Text(
                                                'Forgot Password ?',
                                                style:TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.grey.shade700,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        const Text("By clicking Login You are accepted our terms and Conditions",style: TextStyle(
                                            color: Colors.black
                                        ),textAlign: TextAlign.center,),
                                        Container(
                                          padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                                          child: TextButton(

                                            onPressed: () async {

                                              if(userName.text!=''&&passWord.text!=''){
                                                HashMap userValues = new HashMap<String, String>();
                                                userValues['email']=userName.text;
                                                userValues['password']=passWord.text;
                                                UserService _userService=UserService();
                                                bool success= await _userService.login(userValues);


                                                if (success) {
                                                  showUploadMessage(context, 'Please Check Your Username & Password');

                                                  return;
                                                }
                                                loggedInAs='Kattan';
                                                print('_userService.getUserId()');

                                                print(_userService.userId());
                                                currentUserId=_userService.userId();
                                                setState(() {

                                                });
                                                print(currentUserId+'              hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>  BranchPageWidget()),
                                                );
                                              }else{
                                                userName.text==''?showUploadMessage(context, 'Please Enter Username'):
                                                    showUploadMessage(context, 'Please Enter Password');
                                              }


                                            },
                                            child: Center(
                                              child: Text("LOGIN", style: TextStyle(color: Colors.black,fontSize: 20),
                                              ),
                                            ),
                                            style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => Colors.yellow.shade700),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(6),

                                                    )
                                                )
                                            ),),
                                        ),
                                        Text('version :0.0.8',style: TextStyle(fontSize: 12,color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.15,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
