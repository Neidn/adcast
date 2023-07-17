import 'package:adcast/app/utils/common_convert.dart';
import 'package:flutter/material.dart';

class KeywordCardBodyWidget extends StatelessWidget {
  final String wishRank;
  final String bidAmt;

  const KeywordCardBodyWidget({
    super.key,
    required this.wishRank,
    required this.bidAmt,
  });

  @override
  Widget build(BuildContext context) {
    String bitAmtComma = numberFormat.format(int.parse(bidAmt));

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('희망 순위'),
              Text(
                (wishRank == '') ? '-' : wishRank,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('입찰가'),
              Text(
                bitAmtComma,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
