import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LotteryDetails {

  List<Map<String, dynamic>> lotteryDetails = [];

  List<Map<String, dynamic>> getLotteryDetails() {
    Map<String, dynamic> usPowerballDetail ={
      "lottoName": "Powerball", 
      "dbTitle": "usPowerballNumber",
      "title": "americanLotteryInfo.title".tr(),
      "highestPrize": "americanLotteryInfo.highestPrize".tr(),
      "frequency": "americanLotteryInfo.frequency".tr(),
      "ticketPrice": "americanLotteryInfo.ticketPrice".tr(),
      "drawDate": "americanLotteryInfo.drawDate".tr(),
      "purchasableArea": "americanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("americanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("americanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("americanLotteryInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 255, 137, 53),
        const Color(0xFFff0000)
      ],
      "buttonColor": const Color(0xFFff0000),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105) 
    };

    Map<String, dynamic> megaMillionDetail = {
      "lottoName": "MegaMillions",
      "dbTitle": "megaMillionNumber",
      "title": "megaMillionsInfo.title".tr(),
      "highestPrize": "megaMillionsInfo.highestPrize".tr(),
      "frequency": "megaMillionsInfo.frequency".tr(),
      "ticketPrice": "megaMillionsInfo.ticketPrice".tr(),
      "drawDate": "megaMillionsInfo.drawDate".tr(),
      "purchasableArea": "megaMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("megaMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("megaMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("megaMillionsInfo.probabilities".tr().split('^')),
      "color": [
        const Color(0xFF00ccff),
        const Color(0xFF0066ff)
      ],
      "buttonColor": const Color(0xFF0066ff),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> euroMillionDetail = {
      "lottoName": "Euromillon",
      "dbTitle": "euroMillionNumber",
      "title": "euroMillionsInfo.title".tr(),
      "highestPrize": "euroMillionsInfo.highestPrize".tr(),
      "frequency": "euroMillionsInfo.frequency".tr(),
      "ticketPrice": "euroMillionsInfo.ticketPrice".tr(),
      "drawDate": "euroMillionsInfo.drawDate".tr(),
      "purchasableArea": "euroMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroMillionsInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 201, 243, 160),
        const Color.fromARGB(255, 45, 50, 198),
      ],
      "buttonColor": Color.fromARGB(255, 45, 50, 198),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

     Map<String, dynamic> euroJackpotDetail = {
      "lottoName": "EuroJackpot",
      "dbTitle": "euroJackpotNumber",
      "title": "euroJackpotInfo.title".tr(),
      "highestPrize": "euroJackpotInfo.highestPrize".tr(),
      "frequency": "euroJackpotInfo.frequency".tr(),
      "ticketPrice": "euroJackpotInfo.ticketPrice".tr(),
      "drawDate": "euroJackpotInfo.drawDate".tr(),
      "purchasableArea": "euroJackpotInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroJackpotInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroJackpotInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroJackpotInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 254, 251, 138), 
        const Color.fromARGB(255, 242, 189, 16), 
      ],
      "buttonColor": const Color.fromARGB(255, 242, 189, 16),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> ukLottoDetail = {
      "lottoName": "UkLotto",
      "dbTitle": "ukLotto",
      "title": "ukLottoInfo.title".tr(),
      "highestPrize": "ukLottoInfo.highestPrize".tr(),
      "frequency": "ukLottoInfo.frequency".tr(),
      "ticketPrice": "ukLottoInfo.ticketPrice".tr(),
      "drawDate": "ukLottoInfo.drawDate".tr(),
      "purchasableArea": "ukLottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("ukLottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("ukLottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("ukLottoInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 255, 194, 218),
        const Color.fromARGB(255, 21, 0, 255), 
      ],
      "buttonColor": const Color.fromARGB(255, 21, 0, 255), 
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> laPrimitivaDetail = {
      "lottoName": "La Primitiva",
      "dbTitle": "laPrimitivaNumber",
      "title": "spanishLaPrimitivaInfo.title".tr(),
      "highestPrize": "spanishLaPrimitivaInfo.highestPrize".tr(),
      "frequency": "spanishLaPrimitivaInfo.frequency".tr(),
      "ticketPrice": "spanishLaPrimitivaInfo.ticketPrice".tr(),
      "drawDate": "spanishLaPrimitivaInfo.drawDate".tr(),
      "purchasableArea": "spanishLaPrimitivaInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("spanishLaPrimitivaInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("spanishLaPrimitivaInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("spanishLaPrimitivaInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 234, 113, 105), Color.fromARGB(255, 255, 165, 0)],
      "buttonColor": Color.fromARGB(255, 255, 165, 0),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> elGordoDetail = {
      "lottoName": "El Gordo de La Primitiva",
      "dbTitle": "elGordoNumber",
      "title": "elGordoLotteryInfo.title".tr(),
      "highestPrize": "elGordoLotteryInfo.highestPrize".tr(),
      "frequency": "elGordoLotteryInfo.frequency".tr(),
      "ticketPrice": "elGordoLotteryInfo.ticketPrice".tr(),
      "drawDate": "elGordoLotteryInfo.drawDate".tr(),
      "purchasableArea": "elGordoLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("elGordoLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("elGordoLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("elGordoLotteryInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 176, 243, 31), Color.fromARGB(255, 0, 128, 0)],
      "buttonColor": Color.fromARGB(255, 0, 128, 0),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> superEnalottoDetail = {
      "lottoName": "SuperEnalotto",
      "dbTitle": "superEnalottoNumber",
      "title": "superEnalottoInfo.title".tr(),
      "highestPrize": "superEnalottoInfo.highestPrize".tr(),
      "frequency": "superEnalottoInfo.frequency".tr(),
      "ticketPrice": "superEnalottoInfo.ticketPrice".tr(),
      "drawDate": "superEnalottoInfo.drawDate".tr(),
      "purchasableArea": "superEnalottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("superEnalottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("superEnalottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("superEnalottoInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 13, 175, 40), Color.fromARGB(255, 227, 220, 89)],
      "buttonColor": Color.fromARGB(255, 13, 175, 40),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> ausPowerballDetail = {
      "lottoName": "Powerball",
      "dbTitle": "ausPowerBallNumber",
      "title": "australiaPowerballInfo.title".tr(),
      "highestPrize": "australiaPowerballInfo.highestPrize".tr(),
      "frequency": "australiaPowerballInfo.frequency".tr(),
      "ticketPrice": "australiaPowerballInfo.ticketPrice".tr(),
      "drawDate": "australiaPowerballInfo.drawDate".tr(),
      "purchasableArea": "australiaPowerballInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("australiaPowerballInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("australiaPowerballInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("australiaPowerballInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 76, 73, 227), Color.fromARGB(255, 215, 37, 37)],
      "buttonColor": Color.fromARGB(255, 215, 37, 37),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> kLottoDetail = {
      "lottoName": "Lotto 6/45",
      "dbTitle": "kLottoNumber",
      "title": "koreanLotteryInfo.title".tr(),
      "highestPrize": "koreanLotteryInfo.highestPrize".tr(),
      "frequency": "koreanLotteryInfo.frequency".tr(),
      "ticketPrice": "koreanLotteryInfo.ticketPrice".tr(),
      "drawDate": "koreanLotteryInfo.drawDate".tr(),
      "purchasableArea": "koreanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("koreanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("koreanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("koreanLotteryInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 174, 20, 246), Color.fromARGB(255, 255, 128, 0)],
      "buttonColor": Color.fromARGB(255, 255, 128, 0),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> jLotto_1Detail = {
      "lottoName": "Lotto 6",
      "dbTitle": "jLottoNumber_1",
      "title": "japaneseLottery6Info.title".tr(),
      "highestPrize": "japaneseLottery6Info.highestPrize".tr(),
      "frequency": "japaneseLottery6Info.frequency".tr(),
      "ticketPrice": "japaneseLottery6Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery6Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery6Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery6Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery6Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery6Info.probabilities".tr().split('^')),
      "color": [Colors.red, Colors.orange],
      "buttonColor": Colors.orange,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> jLotto_2Detail = { 
      "lottoName": "Lotto 7",
      "dbTitle": "jLottoNumber_2",
      "title": "japaneseLottery7Info.title".tr(),
      "highestPrize": "japaneseLottery7Info.highestPrize".tr(),
      "frequency": "japaneseLottery7Info.frequency".tr(),
      "ticketPrice": "japaneseLottery7Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery7Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery7Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery7Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery7Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery7Info.probabilities".tr().split('^')),
      "color": [const Color.fromARGB(255, 220, 237, 33), Colors.red],
      "buttonColor": Colors.red,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> sa_lottoDetail = { 
      "lottoName": "SA Lotto",
      "dbTitle": "saLotto",
      "title": "saLottoInfo.title".tr(),
      "highestPrize": "saLottoInfo.highestPrize".tr(),
      "frequency": "saLottoInfo.frequency".tr(),
      "ticketPrice": "saLottoInfo.ticketPrice".tr(),
      "drawDate": "saLottoInfo.drawDate".tr(),
      "purchasableArea": "saLottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("saLottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("saLottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("saLottoInfo.probabilities".tr().split('^')),
      "color": [Colors.yellow, Colors.orange],
      "buttonColor": Colors.orange,
      "backgroundColor": const Color.fromARGB(255, 242, 162, 42)
    };

    Map<String, dynamic> sa_lottoPlus1Detail = { 
      "lottoName": "Lotto Plus 1",
      "dbTitle": "saLottoPlus1",
      "title": "saLottoPlus1Info.title".tr(),
      "highestPrize": "saLottoPlus1Info.highestPrize".tr(),
      "frequency": "saLottoPlus1Info.frequency".tr(),
      "ticketPrice": "saLottoPlus1Info.ticketPrice".tr(),
      "drawDate": "saLottoPlus1Info.drawDate".tr(),
      "purchasableArea": "saLottoPlus1Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("saLottoPlus1Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("saLottoPlus1Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("saLottoPlus1Info.probabilities".tr().split('^')),
      "color": [const Color.fromARGB(255, 220, 237, 33), Colors.green],
      "buttonColor": Colors.green,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> sa_lottoPlus2Detail = { 
      "lottoName": "Lotto Plus 2",
      "dbTitle": "saLottoPlus2",
      "title": "saLottoPlus2Info.title".tr(),
      "highestPrize": "saLottoPlus2Info.highestPrize".tr(),
      "frequency": "saLottoPlus2Info.frequency".tr(),
      "ticketPrice": "saLottoPlus2Info.ticketPrice".tr(),
      "drawDate": "saLottoPlus2Info.drawDate".tr(),
      "purchasableArea": "saLottoPlus2Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("saLottoPlus2Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("saLottoPlus2Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("saLottoPlus2Info.probabilities".tr().split('^')),
      "color": [const Color.fromARGB(255, 220, 237, 33), Colors.lightBlue],
      "buttonColor": Colors.lightBlue,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> sa_powerballDetail = { 
      "lottoName": "SA Powerball",
      "dbTitle": "saPowerball",
      "title": "saPowerballInfo.title".tr(),
      "highestPrize": "saPowerballInfo.highestPrize".tr(),
      "frequency": "saPowerballInfo.frequency".tr(),
      "ticketPrice": "saPowerballInfo.ticketPrice".tr(),
      "drawDate": "saPowerballInfo.drawDate".tr(),
      "purchasableArea": "saPowerballInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("saPowerballInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("saPowerballInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("saPowerballInfo.probabilities".tr().split('^')),
      "color": [Colors.blue, Colors.red],
      "buttonColor": Colors.red,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> sa_dailyDetail = { 
      "lottoName": "Daily Lotto",
      "dbTitle": "saDailyLotto",
      "title": "saDailyLottoInfo.title".tr(),
      "highestPrize": "saDailyLottoInfo.highestPrize".tr(),
      "frequency": "saDailyLottoInfo.frequency".tr(),
      "ticketPrice": "saDailyLottoInfo.ticketPrice".tr(),
      "drawDate": "saDailyLottoInfo.drawDate".tr(),
      "purchasableArea": "saDailyLottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("saDailyLottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("saDailyLottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("saDailyLottoInfo.probabilities".tr().split('^')),
      "color": [Colors.pink, Colors.red],
      "buttonColor": Colors.red,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105)
    };

    Map<String, dynamic> lotto590Detail = { 
      "lottoName": "Loto 5/90",
      "dbTitle": "cameroon5-90",
      "title": "cmLoto590Info.title".tr(),
      "highestPrize": "cmLoto590Info.highestPrize".tr(),
      "frequency": "cmLoto590Info.frequency".tr(),
      "ticketPrice": "cmLoto590Info.ticketPrice".tr(),
      "drawDate": "cmLoto590Info.drawDate".tr(),
      "purchasableArea": "cmLoto590Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("cmLoto590Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("cmLoto590Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("cmLoto590Info.probabilities".tr().split('^')),
      "color": [Colors.green, Colors.red],
      "buttonColor": Colors.red,
      "backgroundColor": const Color.fromARGB(255, 242, 162, 42)
    };

    lotteryDetails.add(usPowerballDetail);
    lotteryDetails.add(megaMillionDetail);
    lotteryDetails.add(euroMillionDetail);
    lotteryDetails.add(euroJackpotDetail);
    lotteryDetails.add(ukLottoDetail);
    lotteryDetails.add(laPrimitivaDetail);
    lotteryDetails.add(elGordoDetail);
    lotteryDetails.add(superEnalottoDetail);
    lotteryDetails.add(ausPowerballDetail);
    lotteryDetails.add(kLottoDetail);
    lotteryDetails.add(jLotto_1Detail);
    lotteryDetails.add(jLotto_2Detail);
    lotteryDetails.add(sa_lottoDetail);
    lotteryDetails.add(sa_lottoPlus1Detail);
    lotteryDetails.add(sa_lottoPlus2Detail);
    lotteryDetails.add(sa_powerballDetail);
    lotteryDetails.add(sa_dailyDetail);
    lotteryDetails.add(lotto590Detail);

    return lotteryDetails;
  }
}