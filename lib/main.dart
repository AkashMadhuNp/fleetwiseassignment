import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:fleetwise/screens/login_screen.dart';
import 'package:fleetwise/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(VehicleAdapter());
  Hive.registerAdapter(HeaderAdapter());
  Hive.registerAdapter(PnLDataAdapter());

  // Open the Hive box for PnLData
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
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system, 
          home: const LoginScreen(),
        ),
      ),
    );
  }
}