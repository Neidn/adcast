import 'package:adcast/app/data/model/chart/chart_data.dart';
import 'package:adcast/app/data/model/payment/bid_data.dart';
import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:adcast/app/utils/common_convert.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BidCountPieChart extends StatelessWidget {
  final String title;
  final BidData maxBidData;
  final BidData bidData;

  const BidCountPieChart({
    super.key,
    required this.title,
    required this.maxBidData,
    required this.bidData,
  });

  List<ChartData> _getData() {
    var threeArray = [
      int.tryParse(maxBidData.three.toString()) ?? 1,
      int.tryParse(bidData.three.toString()) ?? 0
    ];

    if (threeArray[0] < threeArray[1]) {
      threeArray[1] = threeArray[0];
    }

    // Three data / maxThree data
    var three = (threeArray[1] / threeArray[0]) * 100;

    var fiveArray = [
      int.tryParse(maxBidData.five.toString()) ?? 1,
      int.tryParse(bidData.five.toString()) ?? 0
    ];

    if (fiveArray[0] < fiveArray[1]) {
      fiveArray[1] = fiveArray[0];
    }

    // Five data / maxFive data
    var five = (fiveArray[1] / fiveArray[0]) * 100;

    var tenArray = [
      int.tryParse(maxBidData.ten.toString()) ?? 1,
      int.tryParse(bidData.ten.toString()) ?? 0
    ];

    if (tenArray[0] < tenArray[1]) {
      tenArray[1] = tenArray[0];
    }

    // Ten data / maxTen data
    var ten = (tenArray[1] / tenArray[0]) * 100;

    var thirtyArray = [
      int.tryParse(maxBidData.thirty.toString()) ?? 1,
      int.tryParse(bidData.thirty.toString()) ?? 0
    ];

    if (thirtyArray[0] < thirtyArray[1]) {
      thirtyArray[1] = thirtyArray[0];
    }

    // Thirty data / maxThirty data
    var thirty = (thirtyArray[1] / thirtyArray[0]) * 100;

    return <ChartData>[
      ChartData(
        x: '${englishToNumberMap['three']}분주기\n${threeArray[1]}/${threeArray[0]}',
        y: three,
        text: '${englishToNumberMap['three']}분주기',
        pointColor: pieChartThreeColor,
      ),
      ChartData(
        x: '${englishToNumberMap['five']}분주기\n${fiveArray[1]}/${fiveArray[0]}',
        y: five,
        text: '${englishToNumberMap['five']}분주기',
        pointColor: pieChartFiveColor,
      ),
      ChartData(
        x: '${englishToNumberMap['ten']}분주기\n${tenArray[1]}/${tenArray[0]}',
        y: ten,
        text: '${englishToNumberMap['ten']}분주기',
        pointColor: pieChartTenColor,
      ),
      ChartData(
        x: '${englishToNumberMap['thirty']}분주기\n${thirtyArray[1]}/${thirtyArray[0]}',
        y: thirty,
        text: '${englishToNumberMap['thirty']}분주기',
        pointColor: pieChartThirtyColor,
      ),
    ];
  }

  /// Returns radial bar series with legend.
  List<RadialBarSeries<ChartData, String>> _getRadialBarSeries() {
    final List<RadialBarSeries<ChartData, String>> list =
        <RadialBarSeries<ChartData, String>>[
      RadialBarSeries<ChartData, String>(
        animationDuration: 0,
        // pointRadiusMapper: (ChartSampleData data, _) => data.xValue as String,
        maximumValue: 100,
        radius: '100%',
        gap: '3%',
        innerRadius: '20%',
        cornerStyle: CornerStyle.bothFlat,
        xValueMapper: (ChartData data, _) => data.x as String,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.pointColor,
        dataLabelMapper: (ChartData data, _) => data.text.toString(),
        // dataLabelSettings: const DataLabelSettings(isVisible: true),
        dataSource: _getData(),
      ),
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: title),

      /// To enable the legend for radial bar.
      legend: const Legend(
        isVisible: true,
        iconHeight: 20,
        iconWidth: 20,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: _getRadialBarSeries(),
    );
  }
}
