import 'package:flutter/material.dart';

class PrizeStatusText extends StatelessWidget {
  final String date;
  final String prize;

  const PrizeStatusText({super.key, required this.date, required this.prize});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          date,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.033,
            decoration: TextDecoration.none,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * 0.5, // Restrict the width of the text
          ),
          child: Text(
            prize,
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1, // Limit text to a single line
          ),
        ),
      ],
    );
  }
}
