import 'dart:io';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottery_kr/data/LotteryCardDetails.dart';
import 'package:lottery_kr/service/JackpotService.dart';
import 'package:lottery_kr/service/NotificationService.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/widget/LotteryList.dart';
import 'package:lottery_kr/widget/Widget.dart';
import 'package:lottery_kr/widget/buttons/LotteryHomeButton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedTab = 'USA';
  String dropdownValue = 'usa'.tr();
  List<String> items = ["usa".tr(), "eu".tr(), "uk".tr(), "spain".tr(), "italy".tr(), "aus".tr(), "korea".tr(), "japan".tr(), "sa".tr(), "ca".tr()];
  CommonWidget commonWidget = CommonWidget.instance;
  HelperFunctions helperFunctions = HelperFunctions();

  List<Color> background = [];
  InterstitialAd? _interstitialAd;

  Future<bool> _onWillPop() async {
    return false;
  }
  
  @override
  void initState() {
    super.initState();
    setBackgroundByCountry("USA");
    loadAdWithProbability();
    initializeNotificationAndAlarm();
  }

  void loadAdWithProbability() {
    int randomNumber = Random().nextInt(100);

    if (randomNumber < 30) {
      InterstitialAd.load(
        // adUnitId: Platform.isAndroid ? "ca-app-pub-6838337741832324/4794504637" : "ca-app-pub-6838337741832324/4683759779", 
        adUnitId: Platform.isAndroid ? "ca-app-pub-3940256099942544/1033173712" : "ca-app-pub-3940256099942544/4411468910", // test id 
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _interstitialAd!.show();
            _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose(); 
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('Failed to load interstitial ad: $error');
          },
        ),
      );
    } else {
      print('Ad not loaded (Probability check failed)');
    }
  }


  Future<void> initializeNotificationAndAlarm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasRequestedPermissions = prefs.getBool('hasRequestedPermissions') ?? false;
    PermissionStatus notificationStatus = await Permission.notification.status;
    PermissionStatus alarmStatus = await Permission.scheduleExactAlarm.status;

    if ((notificationStatus.isDenied || notificationStatus.isLimited) && !hasRequestedPermissions) {
      await Permission.notification.request();
    }

    if ((alarmStatus.isDenied || alarmStatus.isLimited) && !hasRequestedPermissions) {
      await Permission.scheduleExactAlarm.request();
    }

    bool isNotificationGranted = await Permission.notification.isGranted;
    bool isAlarmGranted = await Permission.scheduleExactAlarm.isGranted;

    if (isNotificationGranted || isAlarmGranted) {
      await NotificationService.instance.initNotification();
      await JackpoService.instance.getJackpotList().then((value) {
        if (value != null) {
          NotificationService.instance.showAllNotifications(value);
        }
      });
    }

    await prefs.setBool('hasRequestedPermissions', true);
  }


  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: commonWidget.homeDrawerWidget(context, background),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: background,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: dropdownButton()
                    ),
                  ],
                ),
                LotteryList(selectedTab: _selectedTab),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // LotteryHomeButton(buttonText: "Number Analysis", subText: "Analyze your numbers", icon: Icon(Icons.analytics), goToPage: () => helperFunctions.goToResult(context)),
                          LotteryHomeButton(buttonText: "goToCompare".tr(), subText: "goToCompareText".tr(), icon: Icon(Icons.compare_arrows), goToPage: () => helperFunctions.goToCompare(context)),
                          LotteryHomeButton(buttonText: "goToDiscussion".tr(), subText: "goToDiscussionText".tr(), icon: Icon(Icons.people), goToPage: () => helperFunctions.goToDiscussion(context))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LotteryHomeButton(buttonText: "goToContact".tr(), subText: "goToContactText".tr(), icon: Icon(Icons.mail), goToPage: () => showContactDialog(context))
                        ],
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        )
      ),
    );
  }

Widget dropdownButton() {
  return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      isExpanded: true,
      items: items
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (dropdownValue == item)
                      Icon(Icons.check, color: Colors.white),
                  ],
                ),
              ))
          .toList(),
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          if (value == 'usa'.tr()) {
            _selectedTab = 'USA';
            dropdownValue = value!;
          } else if (value == 'eu'.tr()) {
            _selectedTab = 'EU';
            dropdownValue = value!;
          } else if (value == 'uk'.tr()) {
            _selectedTab = 'UK';
            dropdownValue = value!;
          } else if (value == 'spain'.tr()) {
            _selectedTab = 'Spain';
            dropdownValue = value!;
          } else if (value == 'italy'.tr()) {
            _selectedTab = 'Italy';
            dropdownValue = value!;
          } else if (value == 'aus'.tr()) {
            _selectedTab = 'Australia';
            dropdownValue = value!;
          } else if (value == 'korea'.tr()) {
            _selectedTab = 'Korea';
            dropdownValue = value!;
          } else if (value == 'japan'.tr()) {
            _selectedTab = 'Japan';
            dropdownValue = value!;
          } else if (value == 'sa'.tr()) {
            _selectedTab = 'South Africa';
            dropdownValue = value!;
          } else if (value == 'ca'.tr()) {
            _selectedTab = 'Cameroon';
            dropdownValue = value!;
          }
          setBackgroundByCountry(_selectedTab);
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return items.map((String item) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dropdownValue ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            ],
          );
        }).toList();
      },
      buttonStyleData: ButtonStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [background[0], background[1]],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 50,
      ),
      iconStyleData: IconStyleData(iconEnabledColor: Colors.black),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: background,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
      ),
    ),
  );
}

  void setBackgroundByCountry(String country) {
    LotteryCardDetails lotteryCardDetails = LotteryCardDetails();
    setState(() {
      background = [];
      if (country == "USA") {
        for (int i = 0; i < lotteryCardDetails.usLotteries.length; i++) {
          background.addAll(lotteryCardDetails.usLotteries[i]["color"]);
        }
      }
      else if (country == "EU") {
        for (int i = 0; i < lotteryCardDetails.euLotteries.length; i++) {
          background.addAll(lotteryCardDetails.euLotteries[i]["color"]);
        }
      }
      else if (country == "UK") {
        for (int i = 0; i < lotteryCardDetails.ukLotteries.length; i++) {
          background.addAll(lotteryCardDetails.ukLotteries[i]["color"]);
        }
      }
      else if (country == "Spain") {
        for (int i = 0; i < lotteryCardDetails.spainLotteries.length; i++) {
          background.addAll(lotteryCardDetails.spainLotteries[i]["color"]);
        }
      }
      else if (country == "Italy") {
        for (int i = 0; i < lotteryCardDetails.italyLotteries.length; i++) {
          background.addAll(lotteryCardDetails.italyLotteries[i]["color"]);
        }
      }
      else if (country == "Australia") {
        for (int i = 0; i < lotteryCardDetails.ausLotteries.length; i++) {
          background.addAll(lotteryCardDetails.ausLotteries[i]["color"]);
        }
      }
      else if (country == "Korea") {
        for (int i = 0; i < lotteryCardDetails.krLotteries.length; i++) {
          background.addAll(lotteryCardDetails.krLotteries[i]["color"]);
        }
      }
      else if (country == "Japan") {
        for (int i = 0; i < lotteryCardDetails.japanLotteries.length; i++) {
          background.addAll(lotteryCardDetails.japanLotteries[i]["color"]);
        }
      }
      else if (country == "South Africa") {
        for (int i = 0; i < lotteryCardDetails.southAfricanLotteries.length; i++) {
          background.addAll(lotteryCardDetails.southAfricanLotteries[i]["color"]);
        }
      } else if (country == "Cameroon") {
        for (int i = 0; i < lotteryCardDetails.cameroonLotteries.length; i++) {
          background.addAll(lotteryCardDetails.cameroonLotteries[i]["color"]);
        }
      }

      print(background);
    });
  }

  void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('contact'.tr()),
          content: Text("worldlotto52@gmail.com"),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}