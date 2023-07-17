import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/theme/app_colors.dart';

import '/app/controller/keyword/keyword_controller.dart';
import '/app/data/model/keyword/keyword_data.dart';

import '/app/controller/main/main_controller.dart';
import '/app/ui/default/widgets/default_logo_widget.dart';

import '/app/ui/default/keyword/widget/keyword_card_body_widget.dart';
import '/app/ui/default/keyword/widget/keyword_card_footer_widget.dart';
import '/app/ui/default/keyword/widget/keyword_card_header_widget.dart';

class KeywordPage extends GetView<KeywordController> {
  const KeywordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<KeywordController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: _.title.isNotEmpty
                ? Text(
                    _.title,
                    style: Get.textTheme.titleMedium,
                  )
                : const DefaultLogoWidget(),
            centerTitle: false,
            backgroundColor: MainController.to.isDarkMode
                ? mobileDarkBackGroundColor
                : mobileLightBackGroundColor,
            actions: [
              IconButton(
                onPressed: () => _.changeBidExceptionFilter(),
                icon: Icon(
                  _.isBidExceptionFilter
                      ? Icons.filter_alt
                      : Icons.filter_alt_off,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Loading
              (_.isNextLoading || _.isLoading)
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0)),

              // Divider
              const Divider(),

              // Keyword List
              _.keywordListData.isEmpty || _.customerId.isEmpty

                  // No Data
                  ? const Flexible(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'No Data',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )

                  // Data
                  : Expanded(
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
                          final KeywordData keywordData =
                              _.keywordListData[index];

                          final String keyword = keywordData.keyword as String;
                          final String keywordUserLock =
                              keywordData.userLock as String;
                          final String keywordStatus =
                              keywordData.status as String;
                          final String keywordStatusReason =
                              keywordData.statusReason as String;
                          final String keywordBidState =
                              keywordData.bidState as String;
                          final String keywordWishRank =
                              keywordData.wishRank as String;
                          final String keywordBidAmt =
                              keywordData.bidAmt as String;
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

                                const SizedBox(
                                  height: 8,
                                ),

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
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      },
    );
  }
}
