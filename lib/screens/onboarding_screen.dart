import 'package:expenz/constants/colors.dart';
import 'package:expenz/screens/sign_out_screen.dart';
import 'package:expenz/widgets/reusable/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:expenz/data/onboaring_data.dart';
import 'package:expenz/widgets/onboarding/front_screen_card.dart';
import 'package:expenz/widgets/onboarding/shared_onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  //page contraller 
  final PageController _controller = PageController();
  bool showDetailPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //onboarding screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = index == 3;
                    });
                  },
                  children: [
                    const FrontScreenCard(),
                    SharedOnboardingCard(
                      titile: OnboaringData.onboaringDataList[0].title, 
                      imageUrl: OnboaringData.onboaringDataList[0].imageUrl, 
                      discription: OnboaringData.onboaringDataList[0].discription,
                    ),
                    SharedOnboardingCard(
                      titile: OnboaringData.onboaringDataList[1].title, 
                      imageUrl: OnboaringData.onboaringDataList[1].imageUrl, 
                      discription: OnboaringData.onboaringDataList[1].discription,
                    ),
                    SharedOnboardingCard(
                      titile: OnboaringData.onboaringDataList[2].title, 
                      imageUrl: OnboaringData.onboaringDataList[2].imageUrl, 
                      discription: OnboaringData.onboaringDataList[2].discription,
                    ),
                    
                  ],
                ),
                //page indicators
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller, 
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kmainPurpleColor,
                      dotColor: kmainGreyColor,
                    ),
                    ),
                ),
                //Nav button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:!showDetailPage ? GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          _controller.page!.toInt()+1, 
                          duration:const Duration(microseconds: 400), 
                          curve: Curves.easeInOut);
                      },
                      child: LongButtonWidget(
                        buttonName:showDetailPage ? "Get Started" : "Next", 
                        buttonColor: kmainPurpleColor,
                        ),
                    ) : GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder:(context) => const SignOutScreen(),
                           )
                          );
                      },
                      child: LongButtonWidget(
                        buttonName:showDetailPage ? "Get Started" : "Next", 
                        buttonColor: kmainPurpleColor,
                        ),
                    )
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}