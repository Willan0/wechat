// import 'package:flutter/cupertino.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:wechat/data/vos/user_vo/user_vo.dart';
//
// import '../data/data_apply/fire_base_abs.dart';
// import '../data/data_apply/fire_base_impl.dart';
//
// class ProfileBloc extends ChangeNotifier{
//   bool _isDispose= false;
//   UserVO? userVO;
//
//
//   // state instance
//   final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
//
//   // getter
//   GlobalKey get getGlobalQrKey => _globalQrKey;
//
//
//   ProfileBloc(){
//
//   }
//
//   Future logout()=> _fireBaseApply.logout();
//
//   // scan qr
//
//
//   @override
//   void notifyListeners() {
//     // TODO: implement notifyListeners
//     if(!_isDispose){
//       super.notifyListeners();
//     }
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _isDispose = true;
//     _qrViewController?.dispose();
//   }
// }