import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiwayatBerlangsungWidget extends StatefulWidget {
  const RiwayatBerlangsungWidget({super.key});

  @override
  State<RiwayatBerlangsungWidget> createState() =>
      _RiwayatBerlangsungWidgetState();
}

class _RiwayatBerlangsungWidgetState extends State<RiwayatBerlangsungWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeUserBloc(
          RepositoryProvider.of<HomeUserRepository>(context),
        ),
        child: BlocBuilder<HomeUserBloc, HomeUserState>(
          builder: (context, state) {
            return ListView();
          },
        ),
      ),
    );
  }
}
