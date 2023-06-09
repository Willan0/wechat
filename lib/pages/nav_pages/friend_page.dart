import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';
import 'package:wechat/pages/conservation_page.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_image.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../../constant/dimen.dart';
import '../../data/vos/user_vo/user_vo.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
  UserVO? userVO;
  List<UserVO> contacts = [];
  @override
  void initState() {
    super.initState();
    userVO = _fireBaseApply.getUserInfoFromAuth();
    String currentUserId = userVO?.id ?? '';
    _fireBaseApply.getAllContactUsers(currentUserId).listen((event) {
      setState(() {
        contacts = event ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 0,),
        title: EasyText(
          text: 'Friends',
          fontSize: kFi17x,
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
      ),
      body: contacts.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                print(contacts[index].file ?? "");
                return FriendView(
                  contacts: contacts[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: kMp10x,
                  ),
              itemCount: contacts.length)
          : Center(
              child: SizedBox(
                child: EasyText(
                  text: 'Currently,There is no friend',
                  color: kPrimaryBlackColor,
                ),
              ),
            ),
    );
  }
}

class FriendView extends StatelessWidget {
  const FriendView({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  final UserVO contacts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.nextScreen(
            context,
            ConservationPage(
              contactUser: contacts,
            ));
      },
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRi10x)),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        child: ListTile(
          leading: CircleAvatar(
              radius: kRi20x,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(kRi20x)),
                  child: EasyImage(image: contacts.file ?? '',))),
          title: EasyText(
            text: contacts.userName ?? '',
            fontSize: kFi17x,
            color: kPrimaryBlackColor,
          ),
          subtitle: EasyText(
            text: contacts.phoneNumber ?? '',
            color: kPrimaryBlackColor,
          ),
        ),
      ),
    );
  }
}
