import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/home_page_bloc.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_image.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../../constant/color.dart';
import '../conservation_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: EasyText(
            text: 'Chats',
            fontSize: kFi17x,
          ),
          centerTitle: true,
          backgroundColor: kSecondaryColor,
        ),
          body: Consumer<HomePageBloc>(
            builder: (context, bloc, child) => ChattingContacts(chattingContacts: bloc.chatting,lastChatVO: bloc.lastChatVOs),
          )),
    );
  }
}

class ChattingContacts extends StatelessWidget {
  const ChattingContacts({
    Key? key, required this.chattingContacts, required this.lastChatVO,
  }) : super(key: key);

  final List<UserVO> chattingContacts;
  final List<ChatVO> lastChatVO;
  @override
  Widget build(BuildContext context) {
    print(chattingContacts.length);
    return chattingContacts.isNotEmpty?ListView.separated(
      itemCount: chattingContacts.length,
      separatorBuilder: (context, index) => SizedBox(height: kMp5x,),
      itemBuilder: (context, index) {
        return chattingContacts.length<1?const Center(child: CircularProgressIndicator(),):ProfileChatContact(chattingContact: chattingContacts[index],lastChatVO: lastChatVO[index],);}
      ):const Center(
        child:
    EasyText(text: 'Currently There is no chats',color: kPrimaryBlackColor,),
      );
  }
}

class ProfileChatContact extends StatelessWidget {
  const ProfileChatContact({
    Key? key,
    required this.chattingContact,required this.lastChatVO,
  }) : super(key: key);

  final UserVO chattingContact;
  final ChatVO? lastChatVO;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.nextScreen(
            context,
            ConservationPage(
              contactUser: chattingContact,
            ));
      },
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kRi10x)),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        child: ListTile(
          leading: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(kRi20x)),
            child: EasyImage(image: chattingContact.file ??'',)),
        ),
        title: EasyText(text:  chattingContact.userName ??'',color: kPrimaryBlackColor,fontSize: kFi17x,),
        subtitle: EasyText(text: lastChatVO?.message ?? '',color: kPrimaryBlackColor,),
        ),
      ),
    );
  }
}
