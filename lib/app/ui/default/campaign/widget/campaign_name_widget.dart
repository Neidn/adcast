import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampaignNameWidget extends StatelessWidget {
  final bool campaignLock;
  final String campaignName;
  final String campaignStatusReason;

  const CampaignNameWidget(
      this.campaignLock, this.campaignName, this.campaignStatusReason,
      {super.key});

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
              style: const TextStyle(
                fontSize: 16,
              ),
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: campaignLock ? campaignStatusReason : "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
