import 'package:baswara_app/widget/logout_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../authentication/presentation/manager/auth_bloc.dart';
import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../onBoarding/presentation/pages/onboarding_page.dart';
import '../widgets/widget.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({
    super.key,
  });

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashBoardAdminWidget(),
    ProfileAdminWidget(),
    ProfileUsersWidget(),
    JenisSampahWidget(),
    SampahUserWidget(),
    InputHargaSampahWidget(),
    TarikSaldoWidget(),
    GrafikPenjualanWidget(),
    CatalogAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorValue.primary,
        centerTitle: true,
        title: Text(
          _selectedIndex == 0
              ? "Baswara"
              : _selectedIndex == 1
                  ? "Profile"
                  : _selectedIndex == 2
                      ? "Profil Pengguna"
                      : _selectedIndex == 3
                          ? "Input Jenis Sampah"
                          : _selectedIndex == 4
                              ? "Input Sampah User"
                              : _selectedIndex == 5
                                  ? "Input Harga Sampah"
                                  : _selectedIndex == 6
                                      ? "Tarik Saldo User"
                                      : _selectedIndex == 7
                                          ? "Grafik Penjualan"
                                          : "Katalog Bertawa",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccesLogout) {
            context.loaderOverlay.hide();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnBoardingPage()));
          }
          if (state is LoadingAuthState) {
            context.loaderOverlay.show();
          }
          if (state is FailureAuthState) {
            context.loaderOverlay.hide();
            Utility(context).showSnackbar(state.msg);
          }
        },
        child: Center(
          child: _widgetOptions[_selectedIndex],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: ColorValue.primary,
              ),
              child: SizedBox.shrink(),
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.home),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Beranda',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.account_circle_rounded),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Profil Admin',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.people),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Profil Pengguna',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.file_copy),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Input Jenis Sampah',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/icon_trash.svg",
                      color: _selectedIndex == 4 ? ColorValue.primary : null),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Input Sampah User',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.attach_money),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Input Harga Sampah',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 5,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/icon_money.svg"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Tarik Saldo User',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 6,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.bar_chart),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Grafik Penjualan',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 7,
              onTap: () {
                _onItemTapped(7);
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: Row(
                children: [
                  const Icon(Icons.shopping_bag),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Katalog Bertawa',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              selected: _selectedIndex == 8,
              onTap: () {
                // Update the state of the app
                _onItemTapped(8);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              title: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => LogoutDialogWidget(
                                blocContext: context,
                              ));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Log out',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              selected: _selectedIndex == 8,
              onTap: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
