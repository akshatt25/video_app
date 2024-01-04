import 'package:flutter/material.dart';

import 'package:video_app/screens/video_screen.dart';

import '../constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  List<Widget> pages = [
    VideoScreen(),
    const Center(
      child: Text("Account"),
    )
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: _page,
            backgroundColor:
                _page == 0 ? GlobalVariables.richBlack : Colors.white,
            iconSize: 30,
            onTap: updatePage,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: _page == 0
                      ? const Icon(
                          Icons.video_collection_rounded,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.video_collection_outlined,
                          color: GlobalVariables.richBlack,
                        ),
                ),
                label: '',
              ),
              // account
              BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: _page == 1
                      ? const Icon(
                          Icons.person_4_rounded,
                          color: GlobalVariables.richBlack,
                        )
                      : const Icon(
                          Icons.person_4_outlined,
                          color: Colors.white,
                        ),
                ),
                label: '',
              ),
            ]));
  }
}
