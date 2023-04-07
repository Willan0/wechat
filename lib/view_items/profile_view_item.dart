
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../constant/string.dart';
import '../pages/loginAndSignUp_pages/login_singUp_page.dart';
import '../widgets/easy_button.dart';

class LogoutButtonView extends StatelessWidget {
  const LogoutButtonView({
    Key? key,
  }) :  super(key: key);

  @override
  Widget build(BuildContext context) {
    final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
    return EasyButton(
        height: kWh50x,
        width: kWh150x,
        onPressed: (){
          _fireBaseApply.logout();
          context.nextReplacement(context,const LoginAndSignUpPage());
        }, color: kSecondaryColor, text: kLogout);
  }
}

class FloatingActionButtonView extends StatefulWidget {
  const FloatingActionButtonView({Key? key, required this.fireBaseApply, this.scannerUser}) : super(key: key);
  final FireBaseApply fireBaseApply;
  final UserVO? scannerUser;
  @override
  State<FloatingActionButtonView> createState() => _FloatingActionButtonViewState();
}

class _FloatingActionButtonViewState extends State<FloatingActionButtonView> {


  final GlobalKey _globalQrKey = GlobalKey();
  QRViewController? _qrViewController;
  Barcode? barcode;
  String receiver_qr_code  = '';
  UserVO? receiverUser ;
  UserVO? scannerUser;

  void scan(QRViewController? qrViewController) async{
    this._qrViewController = qrViewController;
    await _qrViewController?.scannedDataStream.listen((data) {
      barcode =data;
      setState(() {
        receiver_qr_code  = data.code ?? '';
      });
      _qrViewController?.dispose();
      String _scanner_qr_code = widget.scannerUser?.qr_code ?? '';
      widget.fireBaseApply.getUserVO(_scanner_qr_code).then((value) {
         scannerUser = value;
      });
      widget.fireBaseApply.getUserVO(receiver_qr_code ).then((user) {
        setState(() {
          receiverUser = user;
        });
        showDialog(context: context, builder: (context)=> Center(
          child: Container(
            color: kPrimaryColor,
            height: kWh250x,
            width: kWh250x,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyText(text: receiverUser?.userName ?? '',color: kPrimaryBlackColor,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kMp20x),
                  child: Expanded(
                    child: Row(
                      children: [
                        EasyButton(
                          width: kWh50x,
                            height: kWh50x,
                            onPressed: (){
                            context.previousScreen(context);
                            context.previousScreen(context);
                            }, color: kSecondaryColor, text: 'Cancel'),
                        const Spacer(),
                        EasyButton(
                            width: kWh50x,
                            height: kWh50x,
                            onPressed: (){
                                widget.fireBaseApply.setContactUserVO(receiver_qr_code, scannerUser!)
                                    .catchError((e)=>
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: EasyText(text: '$e',)))
                                );
                                widget.fireBaseApply.setContactUserVO(_scanner_qr_code, receiverUser!)
                                .catchError((e)=>
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: EasyText(text: '$e',)))
                                );
                                context.previousScreen(context);
                                context.previousScreen(context);
                            }, color: kSecondaryColor, text: 'Add'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),);
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _qrViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kSecondaryColor,
      child:  Icon(Icons.qr_code_scanner,),
      onPressed: (){
        showDialog(context: context, builder: (context) => Scaffold(
          backgroundColor: kBlackTransparent,
          body: Center(
            child: SizedBox(
              width: kWh250x,
              height: kWh250x,
              child: QRView(
                key: _globalQrKey,
                onQRViewCreated: scan,
              ),
            ),
          ),
        ),);
      },
    );
  }
}
