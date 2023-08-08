import 'package:baswara_app/authentication/data/data_sources/auth_remote_datasources.dart';
import 'package:baswara_app/authentication/data/repositories/auth_repository_impl.dart';
import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/onBoarding/presentation/pages/splash_page.dart';
import 'package:baswara_app/widget/loading_spin_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'bloc_observer.dart';
import 'core/app_theme_data.dart';
import 'core/network_info.dart';

void main() async{
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Connectivity>(
            create: (_) => Connectivity(),
          ),
          RepositoryProvider<NetworkInfo>(
            create: (context) => NetworkInfoImpl(
              RepositoryProvider.of<Connectivity>(context),
            ),
          ),
          RepositoryProvider<AuthRemoteDataSource>(
            create: (_) => AuthRemoteDataSourcesImpl(
              http.Client(),
            ),
          ),
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(
              RepositoryProvider.of<NetworkInfo>(context),
              RepositoryProvider.of<AuthRemoteDataSource>(context),
            ),
          )
        ],
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: const LoadingSpinWidget(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.getTheme(context),
            home: const SplashPage(),
          ),
        ),
      );
    });
  }
}
