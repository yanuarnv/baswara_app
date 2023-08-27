import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../widget/no_internet_dialog.dart';

class CatalogUserPage extends StatelessWidget {
  const CatalogUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorValue.primary,
        title: Text(
          "Katalog Baswara",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            HomeUserBloc(RepositoryProvider.of<HomeUserRepository>(context))
              ..add(GetCatalogUser()),
        child: BlocConsumer<HomeUserBloc, HomeUserState>(
          listener: (context, state) {
            if (state is NoInternetHomeUser) {
              context.loaderOverlay.hide();
              showDialog(
                  context: context,
                  builder: (context) => const NoInternetDialog());
            }
            if (state is LoadingHomeUserState) {
              context.loaderOverlay.show();
            }
            if (state is SuccesGetCatalogUser) {
              context.loaderOverlay.hide();
            }
            if (state is FailureHomeUserState) {
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          builder: (context, state) {
            if (state is SuccesGetCatalogUser) {
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
                    state.data.data.isEmpty
                        ? Center(
                            child: Text(
                            "Catalog tidak tersedia",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ))
                        : GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            itemCount: state.data.data.length > 4
                                ? 4
                                : state.data.data.length,
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 14,
                                    crossAxisCount: 2),
                            itemBuilder: (c, i) => GestureDetector(
                                  onTap: () async {
                                    await launchUrl(
                                        Uri.parse(state.data.data[i].url),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          state.data.data[i].imageUrl,
                                          fit: BoxFit.cover,
                                          width: 146,
                                          height: 98,
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          state.data.data[i].name,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: ColorValue.primary),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
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
