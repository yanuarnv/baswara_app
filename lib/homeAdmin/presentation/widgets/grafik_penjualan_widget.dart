import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entities/product_chart_entity.dart';

class GrafikPenjualanWidget extends StatefulWidget {
  const GrafikPenjualanWidget({super.key});

  @override
  State<GrafikPenjualanWidget> createState() => _GrafikPenjualanWidgetState();
}

class _GrafikPenjualanWidgetState extends State<GrafikPenjualanWidget> {
  List<ProductChartEntity> data = [
    const ProductChartEntity("2023-01-03", 10),
    const ProductChartEntity("2023-03-05", 20),
    const ProductChartEntity("2023-04-07", 21),
    const ProductChartEntity("2023-05-08", 22),
    const ProductChartEntity("2023-07-09", 20),
    const ProductChartEntity("2023-08-01", 19),
    const ProductChartEntity("2023-09-13", 30),
    const ProductChartEntity("2023-10-21", 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Bulan",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 151,
              child: DropdownButtonFormField<int>(
                isDense: true,
                value: 1,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  labelStyle: GoogleFonts.poppins(fontSize: 14),
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('Januari',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Febuari',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text(
                      'Maret',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Add more items as needed
                ],
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Grafik Penjualan Sampah (KG) / Bulan",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SfCartesianChart(
                    borderWidth: 0,
                    backgroundColor: Colors.grey.shade300,
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat("MMM"),
                      minimum: DateTime.parse("${DateTime.now().year}-01-01"),
                      intervalType: DateTimeIntervalType.months,
                      interval: 1,
                      plotOffset: 10,
                      edgeLabelPlacement: EdgeLabelPlacement.none,
                      minorTickLines: const MinorTickLines(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      minorGridLines: const MinorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(width: 0),
                      majorGridLines: const MajorGridLines(
                          color: Colors.grey, dashArray: [3, 2]),
                    ),
                    series: <ChartSeries<ProductChartEntity, DateTime>>[
                      // Renders column chart
                      ColumnSeries<ProductChartEntity, DateTime>(
                          color: Colors.green,
                          dataSource: data,
                          xValueMapper: (ProductChartEntity data, _) =>
                              DateTime.parse(data.date),
                          yValueMapper: (ProductChartEntity data, _) =>
                              data.weight)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
