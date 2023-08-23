import 'package:flutter/material.dart';

class TarikSaldoWidget extends StatefulWidget {
  const TarikSaldoWidget({super.key});

  @override
  State<TarikSaldoWidget> createState() => _TarikSaldoWidgetState();
}

class _TarikSaldoWidgetState extends State<TarikSaldoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(),
      ),
    );
  }
}
