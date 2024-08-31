import 'package:expenz/model/onboarding_model.dart';

class OnboaringData {
  static final List<OnboardingModel> onboaringDataList = [
    OnboardingModel(
      imageUrl: "assets/images/onboard_1.png", 
      title: "Gain total control of your money", 
      discription: "Become your own money manager and make every cent count"
      ),
    OnboardingModel(
      imageUrl: "assets/images/onboard_2.png", 
      title: "Know where your money goes", 
      discription: "Track your transaction easily,with categories and financial report "
      ),
    OnboardingModel(
      imageUrl: "assets/images/onboard_3.png", 
      title: "Planning ahead", 
      discription: "Setup your budget for each category so you in control"
      ),
  ];
}