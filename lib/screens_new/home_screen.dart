import 'package:flutter/material.dart';
import 'package:text_recognition/models/nav_model.dart';
import 'package:text_recognition/screens_new/pages/home_page.dart';
import 'package:text_recognition/screens_new/pages/saves_page.dart';
import 'package:text_recognition/utils/utils.dart';
import 'package:text_recognition/utils/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  final List<NavModel> navModelList = [
    NavModel(
      isSelected: true,
      imageIcon: const ImageIcon(
        AssetImage('$assetsPath/home_icon.png'),
        size: 24,
        color: Colors.white,
      ),
      name: 'Home',
    ),
    NavModel(
      isSelected: false,
      imageIcon: const ImageIcon(
        AssetImage('$assetsPath/saves_icon.png'),
        size: 24,
        color: Colors.white,
      ),
      name: 'Saves',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary300,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  for (NavModel navModel in navModelList) {
                    navModel.isSelected = false;
                  }
                  navModelList[value].isSelected = true;
                  setState(() {});
                },
                children: const [
                  HomePage(),
                  SavesPage(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            NavBar(
              navModelList: navModelList,
              onPageChanged: (int index) {
                for (NavModel navModel in navModelList) {
                  navModel.isSelected = false;
                }
                navModelList[index].isSelected = true;
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn);
                setState(() {});
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
