import 'package:flutter/material.dart';

class LotteryColoredBonusBall extends StatefulWidget {
  final dynamic number;
  const LotteryColoredBonusBall({super.key, required this.number});

  @override
  State<LotteryColoredBonusBall> createState() => _LotteryColoredBonusBallState();
}

class _LotteryColoredBonusBallState extends State<LotteryColoredBonusBall> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: screenWidth * 0.09,
      height: screenWidth * 0.09,
      margin: EdgeInsets.only(right: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, 
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        widget.number.toString(), 
        style: TextStyle(
          fontSize: screenHeight * 0.015, 
          fontWeight: FontWeight.bold, 
          color: Colors.white,
          decoration: TextDecoration.none
        ),
      ),
    );
  }
}
