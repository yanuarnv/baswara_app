import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_chart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardAdminWidget extends StatefulWidget {
  const DashBoardAdminWidget({super.key});

  @override
  State<DashBoardAdminWidget> createState() => _DashBoardAdminWidgetState();
}

class _DashBoardAdminWidgetState extends State<DashBoardAdminWidget> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 21,
              ),
              Text(
                "Selamat Datang, Admin!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorValue.primary,
                ),
              ),
              Text(
                "Tetap pantau sampah yang masuk agar sampah dapat terdaur ulang dengan baik",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(color: ColorValue.primary, width: 3))),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_shoping_circle.svg"),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Penjualan (Rp)",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorValue.primary,
                            ),
                          ),
                          Text(
                            "Rp. 2000.000",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(color: ColorValue.primary, width: 3))),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_shoping_circle.svg"),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Penjualan (KG)",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorValue.primary,
                            ),
                          ),
                          Text(
                            "200 KG",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
