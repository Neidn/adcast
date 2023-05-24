import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/controller/keyword/keyword_controller.dart';
import '/app/data/model/keyword/keyword_data.dart';

import '/app/ui/default/keyword/widget/keyword_card_body_widget.dart';
import '/app/ui/default/keyword/widget/keyword_card_footer_widget.dart';
import '/app/ui/default/keyword/widget/keyword_card_header_widget.dart';

class KeywordPage extends GetView<KeywordController> {
  const KeywordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<KeywordController>(
          initState: (state) {},
          builder: (_) {
            if (_.keywordListData.isEmpty) {
              return const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (_.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _.scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: _.keywordListData.length,
                    itemBuilder: (context, index) {
                      final KeywordData keywordData = _.keywordListData[index];

                      final String keyword = keywordData.keyword as String;
                      final String keywordUserLock =
                          keywordData.userLock as String;
                      final String keywordStatus = keywordData.status as String;
                      final String keywordStatusReason =
                          keywordData.statusReason as String;
                      final String keywordBidState =
                          keywordData.bidState as String;
                      final String keywordWishRank =
                          keywordData.wishRank as String;
                      final String keywordBidAmt = keywordData.bidAmt as String;
                      final String keywordDiagnoseTxt =
                          keywordData.diagnoseTxt as String;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            // Keyword Header
                            KeywordCardHeaderWidget(
                              keyword: keyword,
                              userLock: keywordUserLock,
                              status: keywordStatus,
                              bidState: keywordBidState,
                            ),
                            const Divider(),

                            // Keyword Rank And Amount
                            KeywordCardBodyWidget(
                              wishRank: keywordWishRank,
                              bidAmt: keywordBidAmt,
                            ),
                            const Divider(),

                            // Keyword Status
                            KeywordCardFooterWidget(
                              statusReason: keywordStatusReason,
                              userLock: keywordUserLock,
                              diagnoseTxt: keywordDiagnoseTxt,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (_.isNextLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
