// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:playkosmos/constants/api.dart';
// import 'package:playkosmos/features/authentication/view/create_account_screen.dart';
// import 'package:playkosmos/features/starter/model/onboading_info_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../constants/app_images.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../services/repo/api_string.dart';

// class OnboardViewModel extends ChangeNotifier {
//   OnboardViewModel() {
//     /// call the update the circular button method when onboard
//     _updateCircularButtonPercentage();

//     ///call the get language method when onboard load
//     getLanguageList();
//   }

//   ///uses is to store the language list
//   var _languageLists;
//   get languageLists => _languageLists;

//   ///uses to store the country code
//   String? _countryCode;
//   String? get countryCode => _countryCode;

//   ///uses to store the selected page index
//   int _selectedPageIndex = 0;
//   int get selectedPageIndex => _selectedPageIndex;

//   ///uses to track the onboard page controller
//   PageController _pageController = PageController();
//   PageController get pageController => _pageController;

//   ///uses to store the langauge list fom the api
//   var _languagesWithIcon = [];
//   get languagesWithIcon => _languagesWithIcon;

//   TextEditingController searchController = TextEditingController();
//   bool showSearchedLanguage = false;
//   String? selectedLang = "English(US)";

//   /// this contains the onboard list details
//   List<OnboadingInfoModel> onboardingPages = [
//     OnboadingInfoModel(AppImages.MeetImg, 'meet'.tr(), 'find_and_connect'.tr()),
//     OnboadingInfoModel(
//         AppImages.CreateImg, 'create'.tr(), 'create_team_store'.tr()),
//     OnboadingInfoModel(
//         AppImages.EarnImg, 'earn'.tr(), 'earn_point_and_redeem'.tr()),
//     OnboadingInfoModel(AppImages.StayConnectedImg, 'book'.tr(),
//         'onboard_four_description'.tr()),
//   ];

//   ///uses to store last page index
//   bool get isLastPage => selectedPageIndex == onboardingPages.length - 1;

//   ///uses to store the first page index
//   bool get isFirstPage => selectedPageIndex == onboardingPages[0];

//   ///uses to stores onboard circular button
//   ///it start at 0.25, and end at 1.0
//   double _circularButtonPercentage = 0.25;
//   double get circularButtonPercentage => _circularButtonPercentage;

//   ///this contains the local language list with emoji and language code
//   List LanguageDataList = [
//     {
//       "name": "English",
//       "lang": "English (UK)",
//       "flag": "🇬🇧",
//       "local": "en_UK",
//     },
//     {
//       "name": "English",
//       "lang": "English (US)",
//       "flag": "🇺🇸",
//       "local": "en_US",
//     },
//     {
//       "name": "Suomalinen",
//       "lang": "Suomalinen (FI)",
//       "flag": "🇫🇮",
//       "local": "fi_FI",
//     },
//     {
//       "name": "French",
//       "lang": "French (FR)",
//       "flag": "🇫🇷",
//       "local": "fr_FR",
//     },
//     {
//       "name": "Chinese",
//       "lang": "Chinese (CH)",
//       "flag": "🇨🇳",
//       "local": "zh_CH",
//     },
//     {
//       "name": "Tamill",
//       "lang": "Tamil (SL)",
//       "flag": "🇱🇰",
//       "local": "si_SL",
//     },
//     {
//       "name": "Sinhala",
//       "lang": "Sinhala (SL)",
//       "flag": "🇱🇰",
//       "local": "tl_SL",
//     },
//     {
//       "name": "Hindi",
//       "lang": "Hindi (IN)",
//       "flag": "🇮🇳",
//       "local": "hi_IN",
//     }
//   ];

//   ///uses to decode the utf language from api
//   String utf8convert(String text) {
//     List<int> bytes = text.toString().codeUnits;
//     return utf8.decode(bytes);
//   }

//   ///uses to get the language from the api
//   getLanguageList() async {
//     var response = await http.get(Uri.parse(languageUrl));
//     try {
//       _languagesWithIcon = await json.decode(utf8convert(response.body));

//       //if the language api is unavailable
//       //it uses the local language
//       _languageLists =
//           languagesWithIcon.length == 0 ? LanguageDataList : languagesWithIcon;

//       notifyListeners();
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   ///uses to update the page index on-page-change
//   openNextIndex(int page) {
//     _selectedPageIndex = page;
//     _updateCircularButtonPercentage();

//     notifyListeners();
//   }

//   ///uses to update the circular button percentage
//   setCircularBtn(value) {
//     _circularButtonPercentage += value;
//     notifyListeners();
//   }

//   ///update the arrow button circularButtonPercentage value
//   ///based on the selected page index
//   _updateCircularButtonPercentage() {
//     _circularButtonPercentage = selectedPageIndex == 0
//         ? 0.25
//         : selectedPageIndex == 1
//             ? 0.5
//             : selectedPageIndex == 2
//                 ? 0.75
//                 : selectedPageIndex == 3
//                     ? 1.0
//                     : 0.0;

//     notifyListeners();
//   }

//   ///uses to skip to the last slide
//   skipToLastSlide() {
//     _selectedPageIndex = 3;
//     _circularButtonPercentage = 1.0;
//     navigateToLastSlide();
//     notifyListeners();
//   }

//   ///uses to reset the selected page index
//   resetSelectedPageIndex() {
//     _selectedPageIndex = 0;
//     notifyListeners();
//   }

//   ///uses to naviage to previous page
//   prevPage(context) {
//     if (selectedPageIndex == 0) {
//       Navigator.pop(context);
//     } else {
//       pageController.previousPage(
//           duration: Duration(milliseconds: 400), curve: Curves.ease);
//     }
//   }

//   ///uses to navigate next page
//   nextPage(BuildContext context) {
//     if (isLastPage) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CreateAccountScreen()),
//       );
//     } else {
//       pageController.nextPage(
//           duration: Duration(milliseconds: 400), curve: Curves.ease);
//     }
//   }

//   ///uses to skip the pageview to the last index
//   navigateToLastSlide() {
//     pageController.animateToPage(3,
//         curve: Curves.ease, duration: Duration(milliseconds: 400));
//     notifyListeners();
//   }

//   ///this is uses to fetch the country code
//   getCountryCode() async {
//     http.Response response = await http.get(Uri.parse(ApiString.location_uri));
//     Map data = jsonDecode(response.body);
//     _countryCode = data['countryCode'];
//     notifyListeners();
//   }

//   //clear language textfield
//   void clearTextField(context) {
//     Timer(Duration(seconds: 1), () {
//       searchController.clear();
//       FocusScope.of(context).unfocus();
//     });

//     Timer(Duration(milliseconds: 2800), () {
//       setShowSearchedLanguage(false);
//     });
//     notifyListeners();
//   }

//   setShowSearchedLanguage(bool lang) {
//     showSearchedLanguage = lang;
//     notifyListeners();
//   }

//   setLanguageText(text) async {
//     SharedPreferences sharePreference = await SharedPreferences.getInstance();
//     sharePreference.setString('language-name', text);
//     selectedLang = text;

//     notifyListeners();
//   }

//   ///uses to dispose the controller
//   @override
//   void dispose() {
//     pageController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }
// }
