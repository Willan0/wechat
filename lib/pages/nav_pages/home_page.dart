import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/conservation_bloc.dart';
import 'package:wechat/bloc/home_page_bloc.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../../constant/color.dart';

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
            builder: (context, bloc, child) => ChattingContacts(chattingContacts: bloc.contactUsersId),
          )),
    );
  }
}

class ChattingContacts extends StatelessWidget {
  const ChattingContacts({
    Key? key, required this.chattingContacts,
  }) : super(key: key);

  final List<Object?> chattingContacts;
  @override
  Widget build(BuildContext context) {
    print(chattingContacts.length);
    return ListView.separated(
      itemCount: chattingContacts.length,
      separatorBuilder: (context, index) => SizedBox(height: kMp5x,),
      itemBuilder: (context, index) {
        return ProfileChatContact(chattingContact: chattingContacts[index]);}
      );
  }
}

class ProfileChatContact extends StatelessWidget {
  const ProfileChatContact({
    Key? key,
    required this.chattingContact,
  }) : super(key: key);

  final Object? chattingContact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
    child: Container(),
    ),
    title: EasyText(text: '' ,color: kSecondaryColor,),
    subtitle: EasyText(text: '',color: kSecondaryColor,),
    );
  }
}
