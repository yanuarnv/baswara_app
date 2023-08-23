import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/tambah_catalog_page.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/catalog_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';
import '../../../homeUser/presentation/manager/home_user_bloc.dart';
import '../../../widget/no_internet_dialog.dart';

class CatalogAdmin extends StatelessWidget {
  const CatalogAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AdminBloc(RepositoryProvider.of<AdminRepository>(context))
              ..add(GetCatalogAdmin()),
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is NoInternetHomeUser) {
              context.loaderOverlay.hide();
              showDialog(
                  context: context,
                  builder: (context) => const NoInternetDialog());
            }
            if (state is LoadingAdminState) {
              context.loaderOverlay.show();
            }
            if (state is FailureAdminState) {
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          builder: (context, state) {
            if (state is SuccesGetCatalogAdmin) {
              context.loaderOverlay.hide();
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(),
                    () {
                      context.read<HomeUserBloc>().add(GetCatalogUser());
                    },
                  );
                  return;
                },
                child: Stack(
                  children: [
                    ListView(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "No",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "Nama",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "Aksi",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.data.data.length,
                                      itemBuilder: (c, index) =>
                                          CatalogItemWidget(
                                        product: state.data.data[index],
                                        index: index,
                                        edit: () async {},
                                        delete: () async {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TambahCatalogPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Tambah Jenis Sampah",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
