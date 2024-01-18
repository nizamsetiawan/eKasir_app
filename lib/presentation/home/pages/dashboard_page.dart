import 'package:ekasir_app/data/datasources/auth_local_datasource.dart';
import 'package:ekasir_app/presentation/auth/pages/login_page.dart';
import 'package:ekasir_app/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Dashboard',
          ),
          actions: [
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeMap(
                    orElse: () {},
                    success: (_) {
                      AuthLocalDatasource().removeAuthData();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    });
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(LogoutEvent.logout());
                  },
                  icon: const Icon(Icons.logout),
                );
              },
            )
          ]),
      body: const Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}
