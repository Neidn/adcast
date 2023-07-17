import 'package:adcast/app/controller/main/main_controller.dart';
import 'package:adcast/app/controller/payment/payment_controller.dart';
import 'package:adcast/app/ui/default/payment/widget/payment_goods_table.dart';
import 'package:adcast/app/ui/default/widgets/default_logo_widget.dart';
import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  DataRow dataRow({
    required String title,
    required String value,
  }) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 60,
            child: Text(title),
          ),
        ),
        DataCell(
          Text(value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const DefaultLogoWidget(),
        centerTitle: false,
        backgroundColor: MainController.to.isDarkMode
            ? mobileDarkBackGroundColor
            : mobileLightBackGroundColor,
      ),
      body: GetX<PaymentController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // loading indicator
                _.isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),

                // Divider
                const Divider(),

                SizedBox(
                  height: 500,
                  child: Swiper(
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 0),
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.blue,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: _.goodsData.length,
                    itemBuilder: (context, index) => SizedBox(
                      key: UniqueKey(),
                      width: double.infinity,
                      child: PaymentGoodsTable(
                        goodData: _.goodsData[index],
                      ),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          '계좌 안내',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DataTable(
                        columnSpacing: size.width * 0.3,
                        columns: const [
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            numeric: true,
                            label: Text('Value'),
                          ),
                        ],
                        rows: [
                          dataRow(
                            title: '은행',
                            value: _.bankData.bankName ?? '',
                          ),
                          dataRow(
                            title: '계좌번호',
                            value: _.bankData.bankNum ?? '',
                          ),
                          dataRow(
                            title: '예금주',
                            value: _.bankData.bankOwner ?? '',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
