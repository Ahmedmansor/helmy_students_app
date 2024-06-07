import 'package:flutter/material.dart';
import 'package:helmy/views/dash_board/presentation/views/on%20Boarding/widgets/page_view_item.dart';

// ignore: must_be_immutable
class CustomPageView extends StatelessWidget {
  CustomPageView({super.key, required this.pageController});

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        PageViewItem(
          image: 'assets/images/onBoarding_1.svg',
          title: 'Login Admin',
          subtitle: 'Login With Your Admin Email And Password',
        ),
        PageViewItem(
            image: 'assets/images/onBoarding_2.svg',
            title: 'Showing All Students Data',
            subtitle: 'Acess To View All the Students Data'),
        PageViewItem(
            image: 'assets/images/onBoarding_3.svg',
            title: 'Dashboard Controling',
            subtitle: 'Get Acess To Control All the Students Data')
      ],
    );
  }
}
