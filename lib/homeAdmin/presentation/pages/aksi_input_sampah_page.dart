import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../widget/no_internet_dialog.dart';
import '../manager/admin_bloc.dart';
import '../widgets/category_item_widget.dart';

class AksiInputSampahPage extends StatelessWidget {
  const AksiInputSampahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorValue.primary,
        centerTitle: true,
        title: Text(
          "Input Sampah User",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            AdminBloc(RepositoryProvider.of<AdminRepository>(context))
              ..add(
                GetAllCategory(),
              ),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(),
                  () {
                    BlocProvider.of<AdminBloc>(context).add(GetAllCategory());
                  },
                );
                return;
              },
              child: Stack(
                children: [
                  ListView(),
                  BlocConsumer<AdminBloc, AdminState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is NoConnection) {
                        context.loaderOverlay.hide();
                        showDialog(
                            context: context,
                            builder: (context) => const NoInternetDialog());
                      }
                      if (state is SuccesProductCRUD) {
                        context.loaderOverlay.hide();
                        BlocProvider.of<AdminBloc>(context).add(GetProduct());
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
                      if (state is SuccesGetAllCategory) {
                        context.loaderOverlay.hide();
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Masukkan Berat Sampah",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorValue.primary,
                                  ),
                                ),
                                Text(
                                  "Masukkan jenis sampah sesuai dengan pengguna kirimkan",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.data.length,
                                  itemBuilder: (context, i) =>
                                      CategoryItemWidget(data: state.data[i]),
                                )
                              ],
                            ),
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
