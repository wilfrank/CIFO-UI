import 'package:cifo_flutter/features/fileManager/presentation/bloc/files_manager_bloc.dart';
import 'package:cifo_flutter/features/home/presentation/bloc/transfer_bloc.dart';
import 'package:cifo_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:cifo_flutter/features/uploadFile/presentation/bloc/file_uploader_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifo_flutter/core/di/injection_container.dart';
import 'package:cifo_flutter/features/signin/presentation/bloc/sign_in_bloc.dart';
import 'package:cifo_flutter/features/signin/presentation/screens/login_screen.dart';


class AppState extends StatelessWidget {
  final InjectionContainerImpl injectionContainerImpl;

  const AppState({
    super.key,
    required this.injectionContainerImpl,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => injectionContainerImpl.sl<SignInBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => injectionContainerImpl.sl<RegisterBloc>(),
        ),
        BlocProvider<TransferBloc>(
          create: (context) => injectionContainerImpl.sl<TransferBloc>(),
        ),
        BlocProvider<FileManagerBloc>(
          create: (context) => injectionContainerImpl.sl<FileManagerBloc>(),
        ),
        BlocProvider<FileUploaderBloc>(
          create: (context) => injectionContainerImpl.sl<FileUploaderBloc>(),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter CiFo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
