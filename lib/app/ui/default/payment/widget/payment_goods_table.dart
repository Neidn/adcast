import 'package:adcast/app/data/model/payment/bid_data.dart';
import 'package:adcast/app/data/model/payment/good_data.dart';
import 'package:adcast/app/utils/common_convert.dart';
import 'package:flutter/material.dart';

class PaymentGoodsTable extends StatelessWidget {
  final GoodData goodData;

  const PaymentGoodsTable({
    super.key,
    required this.goodData,
  });

  DataRow dataRow({
    required String title,
    required String value,
  }) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 80,
            child: Text(title),
          ),
        ),
        DataCell(
          Text(value),
        ),
      ],
    );
  }

  List<DataRow> bidDataRow({
    required BidData bid,
  }) {
    final tmpBid = bid.toJson();

    tmpBid.remove('total');
    return tmpBid.entries.map((e) {
      final int count = int.tryParse(e.value) ?? 0;
      final String title = '${englishToNumberMap[e.key]}';

      Widget value;

      switch (count) {
        case 0:
          value = const Text(
            '불가',
            style: TextStyle(
              color: Colors.red,
            ),
          );
          break;
        default:
          value = Text('${numberFormat.format(count)} 건');
          break;
      }

      return DataRow(
        cells: [
          DataCell(
            SizedBox(
              width: 100,
              child: Text(
                "$title 분",
              ),
            ),
          ),
          DataCell(value),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final int price = int.tryParse(goodData.price!) ?? 0;
    final int api = int.tryParse(goodData.api!) ?? 0;

    final BidData bid = BidData(
      total: "${goodData.bid!['total'] ?? 0}",
      three: "${goodData.bid!['3'] ?? 0}",
      five: "${goodData.bid!['5'] ?? 0}",
      ten: "${goodData.bid!['10'] ?? 0}",
      thirty: "${goodData.bid!['30'] ?? 0}",
    );

    final int totalKeywordCount =
        bid.total != null ? int.tryParse(bid.total!) ?? 0 : 0;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  goodData.name!,
                  style: const TextStyle(
                    fontSize: 24,
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
                    title: '월 이용 요금',
                    value: '${numberFormat.format(price)} 원 / 월',
                  ),
                  dataRow(
                    title: '등록 계정 수',
                    value: '${numberFormat.format(api)} 개',
                  ),
                  dataRow(
                    title: '입찰 키워드 수',
                    value: '${numberFormat.format(totalKeywordCount)} 개',
                  ),
                ],
              ),
            ],
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
            vertical: 8,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  '기능 및 혜택',
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
                rows: bidDataRow(
                  bid: bid,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
