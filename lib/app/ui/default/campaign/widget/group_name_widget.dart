import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupNameWidget extends StatelessWidget {
  final bool groupLock;
  final String groupName;
  final String groupStatusReason;

  const GroupNameWidget({
    super.key,
    required this.groupLock,
    required this.groupName,
    required this.groupStatusReason,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: groupLock
          ? const Icon(
              Icons.lock,
              color: Colors.red,
            )
          : Icon(
              Icons.lock_open,
              color: Get.theme.secondaryHeaderColor,
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: groupName,
              style: Get.textTheme.titleMedium,
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: groupLock ? groupStatusReason : "",
                  style: Get.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          if (!groupLock)
            Icon(
              Icons.arrow_forward_ios,
              color: Get.theme.secondaryHeaderColor,
            ),
        ],
      ),
    );
  }
}
