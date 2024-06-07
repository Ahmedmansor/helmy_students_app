import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_settings.dart';
import '../../../../../../core/utils/navigation.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../auth/auth_view.dart';
import 'custom_indicator.dart';
import 'custom_page_view.dart';

// ignore: must_be_immutable
class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({
    super.key,
  });

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(pageController: pageController!),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppSettings.defultSize * 25,
          child: Center(
            child: CustomIndicator(
              dotIndex: pageController!.hasClients ? pageController?.page : 0,
            ),
          ),
        ),
        Visibility(
          visible: pageController!.hasClients
              ? (pageController?.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: AppSettings.defultSize * 10,
            right: AppSettings.defultSize * 2,
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff898989),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: AppSettings.defultSize * 10,
          left: AppSettings.defultSize * 10,
          right: AppSettings.defultSize * 10,
          child: CustomGeneralButton(
            text: pageController!.hasClients
                ? (pageController?.page == 2 ? 'Get started' : 'Next')
                : 'Next',
            onTap: () {
              if (pageController!.page! < 2) {
                pageController?.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              } else {
                NavigationUtils.goToAndOff(
                  context, const LoginScreen(),

                  // token != null && token != ""
                  //     ? const DashBoardView()
                  //     :const LoginScreen()
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
