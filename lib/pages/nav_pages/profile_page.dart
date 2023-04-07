import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';



import '../../constant/color.dart';
import '../../constant/dimen.dart';

import '../../data/data_apply/fire_base_abs.dart';
import '../../data/data_apply/fire_base_impl.dart';
import '../../data/vos/user_vo/user_vo.dart';
import '../../view_items/profile_view_item.dart';
import '../../widgets/easy_text.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserVO? userVO;
  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();


 @override
void initState() {
    // TODO: implement initState
    super.initState();
    userVO = _fireBaseApply.getUserInfoFromAuth();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: EasyText(text: 'Profile',fontSize: kFi17x,),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex:1,child: SizedBox()),
          Expanded(flex:5,child: SizedBox(
            child: Center(
              child: QrImage(
                data: userVO?.qr_code ?? '',
                version: QrVersions.auto,
                size: kWh250x,
              ),
            ),
          )),
          LogoutButtonView(),
          SizedBox(height: kWh130x,)
        ],
      ),
      floatingActionButton: FloatingActionButtonView(fireBaseApply: _fireBaseApply,scannerUser: userVO),
    );
  }
}


