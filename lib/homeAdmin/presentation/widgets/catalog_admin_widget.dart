import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/edit_catalog_page.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/catalog_item_widget.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/failure_catalog_dialog.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/success_catalog_dialog.dart';
import 'package:baswara_app/widget/delete_catalog_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../widget/no_internet_dialog.dart';
import '../pages/tambah_catalog_page.dart';

class CatalogAdmin extends StatelessWidget {
  const CatalogAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AdminBloc(RepositoryProvider.of<AdminRepository>(context))
              ..add(GetCatalogAdmin()),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(),
                  () {
                    context.read<AdminBloc>().add(GetCatalogAdmin());
                  },
                );
                return;
              },
              child: Stack(
                children: [
                  ListView(),
                  BlocConsumer<AdminBloc, AdminState>(
                    listener: (context, state) {
                      if (state is NoConnection) {
                        context.loaderOverlay.hide();
                        showDialog(
                            context: context,
                            builder: (context) => const NoInternetDialog());
                      }
                      if (state is LoadingAdminState) {
                        context.loaderOverlay.show();
                      }
                      if (state is SuccesCatallogAdmin) {
                        context.loaderOverlay.hide();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const SuccesCatalogDialog(
                                  msg: "Sukses Hapus Catalog",
                                )).then((value) {
                          context.read<AdminBloc>().add(GetCatalogAdmin());
                        });
                      }
                      if (state is FailureAdminState) {
                        context.loaderOverlay.hide();
                        showDialog(
                            context: context,
                            builder: (context) => FailureCatalogDialog(
                                  msg: state.msg.toString(),
                                ));
                      }
                    },
                    builder: (context, state) {
                      if (state is SuccesGetCatalogAdmin) {
                        context.loaderOverlay.hide();
                        return Padding(
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
                                            edit: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          EditCatalogPage(
                                                              id: state
                                                                  .data
                                                                  .data[index]
                                                                  .id
                                                                  .toString(),
                                                              name: state
                                                                  .data
                                                                  .data[index]
                                                                  .name,
                                                              tautan: state
                                                                  .data
                                                                  .data[index]
                                                                  .url,
                                                              imgUrl: state
                                                                  .data
                                                                  .data[index]
                                                                  .imageUrl)));
                                            },
                                            delete: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      DeleteCatalogDialog(
                                                        idProduct: state.data
                                                            .data[index].id,
                                                        blocContext: context,
                                                      ));
                                            },
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
                                    "Tambah Produk Bertawa",
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
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
