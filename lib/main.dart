import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:fleetwise/screens/login_screen.dart';
import 'package:fleetwise/screens/sample_screen.dart';
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
        create: (context) => AuthBloc(context.read<ApiService>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system, 
          home: const LoginScreen(),
        ),
      ),
    );
  }
}