import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lottery_kr/model/HistoryResult.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotteryService {
  // Private constructor
  LotteryService._privateConstructor();

  // The single instance of the class
  static final LotteryService _instance = LotteryService._privateConstructor();

  // Factory constructor to return the same instance
  factory LotteryService() {
    return _instance;
  }

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getLottoResults(String lottoName) async {
    Map<String, dynamic> results = {};
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        results[lottoName] = doc.data() as Map<String, dynamic>;
      }
      return results;
    } catch (e) {
      print("Error fetching lotto results: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLotteryData(String lottoName) async {
    Map<String, dynamic> data = {};
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        data = doc.data() as Map<String, dynamic>;
      }
      return data;
    } catch (e) {
      print("Error fetching lotto results: $e");
      rethrow;
    }
  }

  Future<List<List<dynamic>>> getMostWorstShownNumbers(String lottoName) async {
    List<List<dynamic>> results = [];
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> res = {};
        res[lottoName] = doc.data() as Map<String, dynamic>;
        results.add(res[lottoName]["frequency"]["most"]);
        results.add(res[lottoName]["frequency"]["mostBonus"]);
        results.add(res[lottoName]["frequency"]["worst"]);
        results.add(res[lottoName]["frequency"]["worstBonus"]);
      }
      return results;
    } catch (e) {
      print("Error fetching lotto results: $e");
      return [];
    }
  }

  int checkUSPowerballPrize(List<String> userNumbers, String userPowerball, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningPowerball = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool powerballMatched = userPowerball == winningPowerball;

    if (matchedNumbers == 5 && powerballMatched) return 0; // 1st prize
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && powerballMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && powerballMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && powerballMatched) return 6; // 7th prize
    if (matchedNumbers == 1 && powerballMatched) return 7; // 8th prize
    if (powerballMatched) return 8; // 9th prize
    
    return -1; // No prize
  }

  int checkMegaMillionsPrize(List<String> userNumbers, String userMegaBall, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningMegaball = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool megaBallMatched = userMegaBall == winningMegaball;

    if (matchedNumbers == 5 && megaBallMatched) return 0; // 1st prize
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && megaBallMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && megaBallMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && megaBallMatched) return 6; // 7th prize
    if (matchedNumbers == 1 && megaBallMatched) return 7; // 8th prize
    if (megaBallMatched) return 8; // 9th prize

    return -1; // No prize
  }

  int checkEuroMillionsPrize(List<String> userNumbers, List<String> userLuckyStars, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    List<String> winningLuckyStars = winningNumbers.getRange(5, 7).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedLuckyStars = userLuckyStars.where((num) => winningLuckyStars.contains(num)).length;

    if (matchedNumbers == 5 && matchedLuckyStars == 2) return 0; // Jackpot
    if (matchedNumbers == 5 && matchedLuckyStars == 1) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4 && matchedLuckyStars == 2) return 3; // 4th prize
    if (matchedNumbers == 4 && matchedLuckyStars == 1) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 2) return 5; // 6th prize
    if (matchedNumbers == 4) return 6; // 7th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 2) return 7; // 8th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 1) return 8; // 9th prize
    if (matchedNumbers == 3) return 9; // 10th prize
    if (matchedNumbers == 1 && matchedLuckyStars == 2) return 10; // 11th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 1) return 11; // 12th prize
    if (matchedNumbers == 2) return 12; // 13th prize

    return -1; // No prize
  }

  int checkEuroJackpotPrize(List<String> userNumbers, List<String> userLuckyStars, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    List<String> winningLuckyStars = winningNumbers.getRange(5, 7).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedLuckyStars = userLuckyStars.where((num) => winningLuckyStars.contains(num)).length;

    if (matchedNumbers == 5 && matchedLuckyStars == 2) return 0; // Jackpot
    if (matchedNumbers == 5 && matchedLuckyStars == 1) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4 && matchedLuckyStars == 2) return 3; // 4th prize
    if (matchedNumbers == 4 && matchedLuckyStars == 1) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 2) return 5; // 6th prize
    if (matchedNumbers == 4) return 6; // 7th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 2) return 7; // 8th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 1) return 8; // 9th prize
    if (matchedNumbers == 3) return 9; // 10th prize
    if (matchedNumbers == 1 && matchedLuckyStars == 2) return 10; // 11th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 1) return 11; // 12th prize

    return -1; // No prize
  }

  int checkUKLottoPrize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize
    if (matchedNumbers == 2) return 5; // 5th prize

    return -1; // No prize
  }

  int checkLaPrimitivaPrize(List<String> userNumbers, String userReintegro, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningComplementary = winningNumbers[6];
    String winningReintegro = winningNumbers[7];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool reintegroMatched = userReintegro == winningReintegro;

    if (matchedNumbers == 6 && reintegroMatched) return 0; // Jackpot
    if (matchedNumbers == 6) return 1; // 2nd prize
    if (matchedNumbers == 5 && userNumbers.contains(winningComplementary)) return 2; // 3rd prize
    if (matchedNumbers == 5) return 3; // 4th prize
    if (matchedNumbers == 4) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (reintegroMatched) return 6; // Reintegro prize (ticket refund)

    return -1; // No prize
  }

  int checkElGordoPrize(List<String> userNumbers, String userClave, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningClave = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool claveMatched = userClave == winningClave;

    if (matchedNumbers == 5 && claveMatched) return 0; // Jackpot
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && claveMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && claveMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && claveMatched) return 6; // 7th prize
    if (matchedNumbers == 2) return 7; // 8th prize
    if (claveMatched) return 8; // 9th prize

    return -1; // No prize
  }

  int checksuperEnalottoNumberPrize(List<String> userNumbers, String userJolly, List<String> winningNumbers) {
    List<String> mainNumbers = winningNumbers.getRange(0, 6).toList();  // First 6 are main numbers
    String winningJolly = winningNumbers[6];  // 7th number is the Jolly number
    int matchedNumbers = userNumbers.where((num) => mainNumbers.contains(num)).length;
    bool jollyMatched = userJolly == winningJolly;

    if (matchedNumbers == 6) return 0; // Jackpot
    if (matchedNumbers == 5 && jollyMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize
    if (matchedNumbers == 2) return 5; // 6th prize

    return -1; // No prize
  }

  int checkAustraliaPowerballPrize(List<String> userNumbers, String userPowerball, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 7).toList();
    String winningPowerball = winningNumbers[7];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool powerballMatched = userPowerball == winningPowerball;

    if (matchedNumbers == 7 && powerballMatched) return 0; // Jackpot
    if (matchedNumbers == 7) return 1; // 2nd prize
    if (matchedNumbers == 6 && powerballMatched) return 2; // 3rd prize
    if (matchedNumbers == 6) return 3; // 4th prize
    if (matchedNumbers == 5 && powerballMatched) return 4; // 5th prize
    if (matchedNumbers == 5) return 5; // 6th prize
    if (matchedNumbers == 4 && powerballMatched) return 6; // 7th prize
    if (matchedNumbers == 3 && powerballMatched) return 7; // 8th prize

    return -1; // No prize
  }

  int checkKoreaLottoPrize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize

    return -1; // No prize
  }

  int checkJapanLotto6Prize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize

    return -1; // No prize
  }

  int checkJapanLotto7Prize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 7).toList();
    List<String> winningBonus = winningNumbers.getRange(7, 9).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedBonusNumbers = userNumbers.where((num) => winningBonus.contains(num)).length;

    if (matchedNumbers == 7) return 0; // 1st prize
    if (matchedNumbers == 6 && matchedBonusNumbers <= 2) return 1; // 2nd prize
    if (matchedNumbers == 6) return 2; // 3rd prize
    if (matchedNumbers == 5) return 3; // 4th prize
    if (matchedNumbers == 4) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedBonusNumbers <= 2) return 5; // 6th prize

    return -1; // No prize
  }

  int checkPrize(String lottoName, List<String> userNumbers, List<String> bonusNumbers, List<Map<String, dynamic>> results) {
    if (lottoName == "usPowerballNumber") {
      return checkUSPowerballPrize(userNumbers, bonusNumbers[0], results[0][lottoName]["number"].split(","));
    }
    else if (lottoName == "megaMillionNumber") {
      return checkMegaMillionsPrize(userNumbers, bonusNumbers[0], results[1][lottoName]['number'].split(","));
    }
    else if (lottoName == "euroMillionNumber") {
      return checkEuroMillionsPrize(userNumbers, bonusNumbers, results[2][lottoName]['number'].split(","));
    }
    else if (lottoName == "euroJackpotNumber") {
      return checkEuroJackpotPrize(userNumbers, bonusNumbers, results[3][lottoName]['number'].split(","));
    }
    else if (lottoName == "ukLotto") {
      return checkUKLottoPrize(userNumbers, results[4][lottoName]['number'].split(","));
    }
    else if (lottoName == "laPrimitivaNumber") {
      return checkLaPrimitivaPrize(userNumbers, bonusNumbers[0], results[5][lottoName]['number'].split(","));
    }
    else if (lottoName == "elGordoNumber") {
      return checkElGordoPrize(userNumbers, bonusNumbers[0], results[6][lottoName]['number'].split(","));
    }
    else if (lottoName == "superEnalottoNumber") {
      return checksuperEnalottoNumberPrize(userNumbers, bonusNumbers[0], results[7][lottoName]['number'].split(","));
    }
    else if (lottoName == "ausPowerBallNumber") {
      return checkAustraliaPowerballPrize(userNumbers, bonusNumbers[0], results[8][lottoName]['number'].split(","));
    }
    else if (lottoName == "kLottoNumber") {
      return checkKoreaLottoPrize(userNumbers, results[9][lottoName]['number'].split(","));
    }
    else if (lottoName == "jLottoNumber_1") {
      return checkJapanLotto6Prize(userNumbers, results[10][lottoName]['number'].split(","));
    }
    else if (lottoName == "jLottoNumber_2") {
      return checkJapanLotto7Prize(userNumbers, results[11][lottoName]['number'].split(","));
    }
    return -1;
  }

  List<List<dynamic>> getSeparatedNumberAndBonus(String numberTxt, String lottoName) {
    List<List<dynamic>> separatedNumbers = [[],[],[]];

    List<dynamic> numbers = numberTxt.split(",");
    switch (lottoName) {
      case "usPowerballNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "megaMillionNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "euroMillionNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = numbers.getRange(5, 7).toList();
        break;
      case "euroJackpotNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = numbers.getRange(5, 7).toList();
        break;
      case "ukLotto":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "laPrimitivaNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        separatedNumbers[2] = [numbers[7]];
        break;
      case "elGordoNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "superEnalottoNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "ausPowerBallNumber":
        separatedNumbers[0] = numbers.getRange(0, 7).toList();
        separatedNumbers[1] = [numbers[7]];
        break;
      case "kLottoNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "jLottoNumber_1":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "jLottoNumber_2":
        separatedNumbers[0] = numbers.getRange(0, 7).toList();
        separatedNumbers[1] = numbers.getRange(7, 9).toList();
        break;
      case "saLotto":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "saLottoPlus1":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "saLottoPlus2":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "saPowerball":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "saDailyLotto":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        break;
      case "cameroon5-90":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        break;
      default:
        break;
    }

    return separatedNumbers;
  }

  Future<void> saveNumbers(String name, List<Map<String, List<dynamic>>> numbers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> numbersToSave = numbers.map((map) {
      return map.map((key, value) => MapEntry(key, value));
    }).toList();
    String numbersJson = jsonEncode(numbersToSave);
    await prefs.setString(name, numbersJson);
  }

  Future askReview(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isReviewed = prefs.getBool("isReviewMade") ?? false;
    if (!isReviewed) {
      try {
        final inAppReview = InAppReview.instance;
        
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showReviewDialog(context);
          });
        }
        
        prefs.setBool("isReviewMade", true);
      } catch (e) {
        print(e.toString());
        prefs.setBool("isReviewMade", true);
      }
    }
  }

  void showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("review".tr()),
          content: Platform.isAndroid ? Text("askAndroidReview".tr()) : Text("askIOSReview".tr()),
          actions: <Widget>[
            TextButton(
              child: Text("no".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("yes".tr()),
              onPressed: () async {
                Navigator.of(context).pop();
                final inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(
                  appStoreId: '6505033228',
                );
              },
            ),
          ],
        );
    });
  }

  Future<bool> saveSeparateNumber(String name, Map<String, List<dynamic>> number, BuildContext context) async {
    try { 
      LotteryService lotteryService = LotteryService();
      // Await the result of loading numbers
      List<Map<String, List<dynamic>>>? numbers = await lotteryService.loadNumbers(name);

      if (numbers != null) {
        NumberGenerateService numberGenerateService = NumberGenerateService();
        int capacity = await numberGenerateService.loadMaxCapacity();
        
        if (numbers.length < capacity) {
          numbers.add(number);
          await lotteryService.saveNumbers(name, numbers);  // Await the save operation
          return true;  // Return true after successful save
        } else {
          HelperFunctions helperFunctions = HelperFunctions();
          if (capacity < 30) {
            helperFunctions.askExpandCapacityDialog(context);  // Show dialog for expanding capacity
          }
          return false;  // Capacity is full
        }
      } else {
        // Create a new list with the first number entry
        List<Map<String, List<dynamic>>> newNumbers = [number];
        await lotteryService.saveNumbers(name, newNumbers);  // Save the new list
        return true;  // Return true after successful save
      }
    } catch (e) {
      print(e.toString());  // Print the error for debugging
      return false;  // Return false if an error occurs
    }
  }

  Future<List<Map<String, List<dynamic>>>?> loadNumbers(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? numbersJson = prefs.getString(name);
    
    if (numbersJson != null) {
      // Decode the JSON back to a List of Maps
      List<dynamic> decodedJson = jsonDecode(numbersJson);
      List<Map<String, List<dynamic>>> numbers = decodedJson.map((item) {
        return Map<String, List<dynamic>>.from(item);
      }).toList();
      
      return numbers;
    }
    
    return null;
  }

  Future<List<HistoryResult>> analyzeNumberByLottoName(String lottoName, List<dynamic> numbers) async {
    if (lottoName == "Powerball") {
      return await analyzeUSPowerballNumber(numbers);
    }
    else if (lottoName == "MegaMillions") {
      return await analyzeMegamillonsNumber(numbers);
    }
    else if (lottoName == "Euromillon") {
      return await analyzeEuroMillionsNumber(numbers);
    }
    else if (lottoName == "AU Powerball") {
      return await analyzeAuPowerballNumber(numbers);
    }
    else if (lottoName == "Lotto 6/45") {
      return await analyzeKLottoNumber(numbers);
    }
    return [];
  }

  Future<List<HistoryResult>> analyzeUSPowerballNumber(List<dynamic> numbers) async {
    final String response = await rootBundle.loadString('assets/lottos/json/Powerball.json');
    final data = await json.decode(response);
    List<HistoryResult> analyzedRanks = [];

    List<dynamic> numberHistory = data["data"];
    for (int i = 0; i < numberHistory.length; i++) {
      List<String> splits = numberHistory[i][1].toString().split(" ");
      int rank = getUSPowerballRank(splits, numbers);
      if (rank != -1) {
        String date = numberHistory[i][0].toString();
        DateTime dateTime = DateTime.parse(date);
        String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
        Map<String, List<String>> num = { "numbers": splits.getRange(0, 5).toList(), "bonus": [splits[5].toString()] };
        analyzedRanks.add(HistoryResult(rank, formattedDate, num));
      }
    }
    analyzedRanks.sort((a, b) => a.rank.compareTo(b.rank));
    return analyzedRanks;
  }

  int getUSPowerballRank(List<String> history, List<dynamic> number) {
    List<String> historyNumber = history.getRange(0, 5).toList();
    List<dynamic> chosenNumbers = number.getRange(0, 5).toList();
    int matchedNumbers = chosenNumbers.where((num) => 
        historyNumber.contains(num.toString()) || historyNumber.contains("0$num")
      ).length;
    bool powerballMatched = history[5] == number[5].toString() || history[5] == "0${number[5].toString}";

    if (matchedNumbers == 5 && powerballMatched) return 1; // 1st prize
    if (matchedNumbers == 5) return 2; // 2nd prize
    if (matchedNumbers == 4 && powerballMatched) return 3; // 3rd prize
    if (matchedNumbers == 4) return 4; // 4th prize
    if (matchedNumbers == 3 && powerballMatched) return 5; // 5th prize
    if (matchedNumbers == 3) return 6; // 6th prize
    if (matchedNumbers == 2 && powerballMatched) return 7; // 7th prize
    if (matchedNumbers == 1 && powerballMatched) return 8; // 8th prize
    if (powerballMatched) return 9; // 9th prize
    
    return -1; // No prize
  }

  Future<List<HistoryResult>> analyzeMegamillonsNumber(List<dynamic> numbers) async {
    final String response = await rootBundle.loadString('assets/lottos/json/MegaMillions.json');
    final data = await json.decode(response);
    List<HistoryResult> analyzedRanks = [];

    List<dynamic> numberHistory = data["data"];
    for (int i = 0; i < numberHistory.length; i++) {
      List<String> splits = numberHistory[i][1].toString().split(" ");
      String megaBall = numberHistory[i][2].toString();
      splits.add(megaBall);
      int rank = getMegaMillionRank(splits, numbers);
      if (rank != -1) {
        String date = numberHistory[i][0].toString();
        DateTime dateTime = DateTime.parse(date);
        String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
        Map<String, List<String>> num = { "numbers": splits.getRange(0, 5).toList(), "bonus": [splits[5].toString()] };
        analyzedRanks.add(HistoryResult(rank, formattedDate, num));
      }
    }
    analyzedRanks.sort((a, b) => a.rank.compareTo(b.rank));
    return analyzedRanks;
  }

  int getMegaMillionRank(List<String> history, List<dynamic> number) {
    List<String> historyNumber = history.getRange(0, 5).toList();
    List<dynamic> chosenNumbers = number.getRange(0, 5).toList();
    int matchedNumbers = chosenNumbers.where((num) => 
        historyNumber.contains(num.toString()) || historyNumber.contains("0$num")
      ).length;
    bool megaBallMatched = history[5] == number[5].toString() || history[5] == "0${number[5].toString}";

    if (matchedNumbers == 5 && megaBallMatched) return 1; // 1st prize
    if (matchedNumbers == 5) return 2; // 2nd prize
    if (matchedNumbers == 4 && megaBallMatched) return 3; // 3rd prize
    if (matchedNumbers == 4) return 4; // 4th prize
    if (matchedNumbers == 3 && megaBallMatched) return 5; // 5th prize
    if (matchedNumbers == 3) return 6; // 6th prize
    if (matchedNumbers == 2 && megaBallMatched) return 7; // 7th prize
    if (matchedNumbers == 1 && megaBallMatched) return 8; // 8th prize
    if (megaBallMatched) return 9; // 9th prize

    return -1; // No prize
  }

  Future<List<HistoryResult>> analyzeEuroMillionsNumber(List<dynamic> numbers) async {
    final String response = await rootBundle.loadString('assets/lottos/json/EuroMillions.json');
    final data = await json.decode(response);
    List<HistoryResult> analyzedRanks = [];

    List<dynamic> numberHistory = data;
    for (int i = 0; i < numberHistory.length; i++) {
      List<dynamic> splits = numberHistory[i]["numbers"];
      List<dynamic> stars = numberHistory[i]["stars"];
      splits.addAll(stars);
      int rank = getEuroMillionRank(splits, numbers);
      if (rank != -1) {
        String date = numberHistory[i]["date"].toString();
        DateFormat inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
        DateTime dateTime = inputFormat.parseUtc(date);
        DateFormat outputFormat = DateFormat("dd MMM yyyy");
        String formattedDate = outputFormat.format(dateTime);
        Map<String, List<String>> num = { "numbers": splits.map((e) => e.toString()).toList(), "bonus": stars.map((e) => e.toString()).toList() };
        analyzedRanks.add(HistoryResult(rank, formattedDate, num));
      }
    }
    analyzedRanks.sort((a, b) => a.rank.compareTo(b.rank));
    return analyzedRanks;
  }

  int getEuroMillionRank(List<dynamic> history, List<dynamic> number) {
    List<dynamic> historyNumber = history.getRange(0, 5).toList();
    List<dynamic> chosenNumbers = number.getRange(0, 5).toList();
    int matchedNumbers = chosenNumbers.where((num) => 
        historyNumber.contains(num.toString())
      ).length;

    List<dynamic> historyStars = history.getRange(5, 7).toList();
    List<dynamic> chosenStars = number.getRange(5, 7).toList();
    int matchedStars = chosenStars.where((num) => 
        historyStars.contains(num.toString())
      ).length;


    if (matchedNumbers == 5 && matchedStars == 2) return 1; // Jackpot
    if (matchedNumbers == 5 && matchedStars == 1) return 2; // 2nd prize
    if (matchedNumbers == 5) return 3; // 3rd prize
    if (matchedNumbers == 4 && matchedStars == 2) return 4; // 4th prize
    if (matchedNumbers == 4 && matchedStars == 1) return 5; // 5th prize
    if (matchedNumbers == 3 && matchedStars == 2) return 6; // 6th prize
    if (matchedNumbers == 4) return 7; // 7th prize
    if (matchedNumbers == 2 && matchedStars == 2) return 8; // 8th prize
    if (matchedNumbers == 3 && matchedStars == 1) return 9; // 9th prize
    if (matchedNumbers == 3) return 10; // 10th prize
    if (matchedNumbers == 1 && matchedStars == 2) return 11; // 11th prize
    if (matchedNumbers == 2 && matchedStars == 1) return 12; // 12th prize
    if (matchedNumbers == 2) return 13; // 13th prize

    return -1; // No prize
  }

  Future<List<HistoryResult>> analyzeAuPowerballNumber(List<dynamic> numbers) async {
    final String response = await rootBundle.loadString('assets/lottos/json/AUPowerball.json');
    final data = await json.decode(response);
    List<HistoryResult> analyzedRanks = [];

    List<dynamic> numberHistory = data;
    for (int i = 0; i < numberHistory.length; i++) {
      List<dynamic> splits = numberHistory[i]["Numbers"];
      dynamic powerBall = numberHistory[i]["Powerball"];
      splits.add(powerBall);
      int rank = getAUPowerballRank(splits, numbers);
      if (rank != -1) {
        String date = numberHistory[i]["Date"].toString();
        DateTime dateTime = DateFormat('dd/MM/yy').parse(date);
        String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
        Map<String, List<String>> num = { "numbers": splits.getRange(0, 7).map((e) => e.toString()).toList(), "bonus": [splits[7].toString()] };
        analyzedRanks.add(HistoryResult(rank, formattedDate, num));
      }
    }
    analyzedRanks.sort((a, b) => a.rank.compareTo(b.rank));
    return analyzedRanks;
  }

  int getAUPowerballRank(List<dynamic> history, List<dynamic> number) {
    List<dynamic> historyNumber = history.getRange(0, 7).toList();
    List<dynamic> chosenNumbers = number.getRange(0, 7).toList();
    int matchedNumbers = chosenNumbers.where((num) => 
        historyNumber.contains(num)
      ).length;
    bool powerballMatched = history[7] == number[7];

    if (matchedNumbers == 7 && powerballMatched) return 1; // Jackpot
    if (matchedNumbers == 7) return 2; // 2nd prize
    if (matchedNumbers == 6 && powerballMatched) return 3; // 3rd prize
    if (matchedNumbers == 6) return 4; // 4th prize
    if (matchedNumbers == 5 && powerballMatched) return 5; // 5th prize
    if (matchedNumbers == 5) return 6; // 6th prize
    if (matchedNumbers == 4 && powerballMatched) return 7; // 7th prize
    if (matchedNumbers == 3 && powerballMatched) return 8; // 8th prize

    return -1; // No prize
  }

  Future<List<HistoryResult>> analyzeKLottoNumber(List<dynamic> numbers) async {
    final String response = await rootBundle.loadString('assets/lottos/json/KoreanBall.json');
    final data = await json.decode(response);
    List<HistoryResult> analyzedRanks = [];

    List<dynamic> numberHistory = data;
    for (int i = 0; i < numberHistory.length; i++) {
      List<dynamic> splits = numberHistory[i]["Numbers"];
      dynamic bonus = numberHistory[i]["Bonus"];
      splits.add(bonus);
      int rank = getKLottoRank(splits, numbers);
      if (rank != -1) {
        String date = numberHistory[i]["Date"].toString();
        DateTime dateTime;
        if (date.contains("/")) {
          dateTime = DateFormat('M/d/yy').parse(date); 
        }
        else {
          dateTime = DateTime.parse(date);
        }
        String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
        Map<String, List<String>> num = { "numbers": splits.getRange(0, 6).map((e) => e.toString()).toList(), "bonus": [splits[6].toString()] };
        analyzedRanks.add(HistoryResult(rank, formattedDate, num));
      }
    }
    analyzedRanks.sort((a, b) => a.rank.compareTo(b.rank));
    return analyzedRanks;
  }

  int getKLottoRank(List<dynamic> history, List<dynamic> number) {
    List<dynamic> historyNumber = history.getRange(0, 6).toList();
    List<dynamic> chosenNumbers = number.getRange(0, 6).toList();
    int matchedNumbers = chosenNumbers.where((num) => 
        historyNumber.contains(num.toString())
      ).length;
    bool bonusMatched = history[6] == number[5];

    if (matchedNumbers == 6) return 1; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 2; // 2nd prize
    if (matchedNumbers == 5) return 3; // 3rd prize
    if (matchedNumbers == 4) return 4; // 4th prize
    if (matchedNumbers == 3) return 5; // 5th prize

    return -1; // No prize
  }
}