import 'package:flutter/material.dart';

class KeywordCardHeaderWidget extends StatelessWidget {
  final String keyword;
  final String userLock;
  final String status;
  final String bidState;

  const KeywordCardHeaderWidget({
    super.key,
    required this.keyword,
    required this.userLock,
    required this.status,
    required this.bidState,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      leading: (userLock == "ON")
          ? const Icon(Icons.lock, color: Colors.red)
          : const Icon(Icons.lock_open, color: Colors.green),
      title: Text(
        keyword,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        (userLock == "ON") ? status : bidState,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: (userLock == "ON") ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
