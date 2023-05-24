import 'package:flutter/material.dart';

class KeywordCardFooterWidget extends StatelessWidget {
  final String statusReason;
  final String userLock;
  final String diagnoseTxt;

  const KeywordCardFooterWidget({
    super.key,
    required this.statusReason,
    required this.userLock,
    required this.diagnoseTxt,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      tileColor: (userLock == "ON") ? Colors.red : Colors.green,
      textColor: Colors.white,
      title: Text(
        (userLock == "ON") ? statusReason : diagnoseTxt,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
