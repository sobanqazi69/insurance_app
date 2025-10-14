import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'shared/services/router_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize SharedPreferences
  await SharedPreferences.getInstance();
  
  runApp(
    DevicePreview(
      enabled: true, // Set to false for production
      builder: (context) => const InsuranceApp(),
    ),
  );
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Auth Repository
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: AuthRemoteDataSourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Auth Bloc
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              loginUseCase: LoginUseCase(context.read<AuthRepository>()),
              registerUseCase: RegisterUseCase(context.read<AuthRepository>()),
              logoutUseCase: LogoutUseCase(context.read<AuthRepository>()),
              checkAuthStatusUseCase: CheckAuthStatusUseCase(context.read<AuthRepository>()),
            )..add(CheckAuthStatus()),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812), // iPhone X design size
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
              routerConfig: RouterService.router,
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
            );
          },
        ),
      ),
    );
  }
}
