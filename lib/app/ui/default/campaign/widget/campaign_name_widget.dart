import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampaignNameWidget extends StatelessWidget {
  final bool campaignLock;
  final String campaignName;
  final String campaignStatusReason;

  const CampaignNameWidget({
    super.key,
    required this.campaignLock,
    required this.campaignName,
    required this.campaignStatusReason,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: campaignLock
          ? const Icon(
              Icons.lock,
              color: Colors.red,
            )
          : Icon(
              Icons.lock_open,
              color: Get.theme.secondaryHeaderColor,
            ),
      title: Row(
        children: [
          RichText(
            text: TextSpan(
              text: campaignName,
              style: Get.textTheme.titleMedium,
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: campaignLock ? campaignStatusReason : "",
                  style: Get.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
