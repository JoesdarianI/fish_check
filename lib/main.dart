import 'package:fish_check/core/theme/app_theme.dart';
import 'package:fish_check/features/auth/data/in_memory_auth_repository.dart';
import 'package:fish_check/features/auth/presentation/auth_cubit.dart';
import 'package:fish_check/features/auth/presentation/login_page.dart';
import 'package:fish_check/features/catches/data/repositories/in_memory_catch_repository.dart';
import 'package:fish_check/features/catches/presentation/blocs/catch_cubit.dart';
import 'package:fish_check/features/catches/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const FishCheckApp());
}

class FishCheckApp extends StatelessWidget {
  const FishCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => InMemoryAuthRepository()),
        RepositoryProvider(create: (_) => InMemoryCatchRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(context.read<InMemoryAuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CatchCubit(context.read<InMemoryCatchRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'FishCheck',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) return const HomePage();
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
