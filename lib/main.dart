import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/BLoC/bloc/auth_event.dart';
import 'package:fleetwise/BLoC/bloc/auth_state.dart';
import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:fleetwise/screens/home_screen.dart';
import 'package:fleetwise/screens/login_screen.dart';
import 'package:fleetwise/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(VehicleAdapter());
  Hive.registerAdapter(HeaderAdapter());
  Hive.registerAdapter(PnLDataAdapter());
  await Hive.openBox<PnLData>('pnlData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiService(),
      child: BlocProvider(
        create: (context) => AuthBloc(context.read<ApiService>())..add(const CheckAuthStatus()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          home: const AuthWrapper(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is Unauthenticated || state is AuthError) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}