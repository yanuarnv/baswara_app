import 'package:baswara_app/homeUser/presentation/widgets/home_user_widget.dart';
import 'package:baswara_app/homeUser/presentation/widgets/profil_user_widget.dart';
import 'package:baswara_app/homeUser/presentation/widgets/riwayat_user_widget.dart';
import 'package:flutter/material.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final ValueNotifier<int> indexSelect = ValueNotifier(0);
  final List<Widget> pages = [
    const HomeUserWidget(),
    const RiwayatUserWidget(),
    const ProfilUserWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: indexSelect,
          builder: (context, value, _) {
            return BottomNavigationBar(
              onTap: (value) {
                indexSelect.value = value;
              },
              currentIndex: value,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Riwayat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded),
                  label: 'Business',
                ),
              ],
            );
          }),
      body: ValueListenableBuilder(
          valueListenable: indexSelect,
          builder: (context, value, _) {
            return pages[value];
          }),
    );
  }
}
