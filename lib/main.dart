import 'package:ekasir_app/core/constants/colors.dart';
import 'package:ekasir_app/data/datasources/auth_local_datasource.dart';
import 'package:ekasir_app/data/datasources/auth_remote_datasource.dart';
import 'package:ekasir_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:ekasir_app/presentation/auth/pages/login_page.dart';
import 'package:ekasir_app/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:ekasir_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter FIC Batch 11',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            textTheme: GoogleFonts.quicksandTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
              color: AppColors.white,
              elevation: 0,
              titleTextStyle: GoogleFonts.quicksand(
                color: AppColors.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              iconTheme: const IconThemeData(
                color: AppColors.primary,
              ),
            ),
          ),
          home: FutureBuilder<bool>(
              future: AuthLocalDatasource().isAuth(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return const DashboardPage();
                } else {
                  return const LoginPage();
                }
              })),
    );
  }
}
