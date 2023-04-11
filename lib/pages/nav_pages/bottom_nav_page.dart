import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/home_page_bloc.dart';

import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/nav_constant.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (context) => HomePageBloc(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_fill), label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2_fill), label: 'People'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_alt_circle_fill), label: 'Me'),
          ],
          selectedItemColor: kSecondaryColor,
          unselectedItemColor: kGreyColor,
          onTap: (index) {
            this.index = index;
            setState(() {});
          },
        ),
        body: IndexedStack(
          index: index,
          children: navPageList,
        ),
      ),
    );
  }
}
