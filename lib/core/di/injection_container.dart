import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/features/fileManager/data/datasource/file_manager_remote_data_source.dart';
import 'package:cifo_flutter/features/fileManager/data/repositories/file_manager_repository_impl.dart';
import 'package:cifo_flutter/features/fileManager/domain/repositories/file_manager_repository.dart';
import 'package:cifo_flutter/features/fileManager/domain/usecase/authenticate_file.dart';
import 'package:cifo_flutter/features/fileManager/domain/usecase/delete_file.dart';
import 'package:cifo_flutter/features/fileManager/domain/usecase/get_files.dart';
import 'package:cifo_flutter/features/fileManager/presentation/bloc/files_manager_bloc.dart';
import 'package:cifo_flutter/features/home/data/datasources/transfer_remote_data_source.dart';
import 'package:cifo_flutter/features/home/data/repositories/transfer_repository_impl.dart';
import 'package:cifo_flutter/features/home/domain/repositories/transfer_repository.dart';
import 'package:cifo_flutter/features/home/domain/usecases/transfer_user.dart';
import 'package:cifo_flutter/features/home/presentation/bloc/transfer_bloc.dart';
import 'package:cifo_flutter/features/uploadFile/data/datasource/file_upload_manager_remote_data_source.dart';
import 'package:cifo_flutter/features/uploadFile/data/repositories/file_upload_manager_repository_impl.dart';
import 'package:cifo_flutter/features/uploadFile/domain/repositories/file_upload_manager_repository.dart';
import 'package:cifo_flutter/features/uploadFile/domain/usecase/upload_file.dart';
import 'package:cifo_flutter/features/uploadFile/presentation/bloc/file_uploader_bloc.dart';

import 'package:cifo_flutter/core/interceptors/interceptor_manager.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:cifo_flutter/features/register/data/datasources/register_remote_data_source.dart';
import 'package:cifo_flutter/features/register/data/repositories/register_repository_impl.dart';
import 'package:cifo_flutter/features/register/domain/repositories/register_repository.dart';
import 'package:cifo_flutter/features/register/domain/usecases/register_user.dart';
import 'package:cifo_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:cifo_flutter/features/signin/data/datasources/sign_in_remote_datasource.dart';
import 'package:cifo_flutter/features/signin/data/repositories/sign_in_repository_impl.dart';
import 'package:cifo_flutter/features/signin/domain/repositories/sign_in_repository.dart';
import 'package:cifo_flutter/features/signin/domain/usecases/sign_in_user.dart';
import 'package:cifo_flutter/features/signin/presentation/bloc/sign_in_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:cifo_flutter/core/http/custom_http_client.dart';
import 'package:cifo_flutter/core/http/dio_client_mix.dart';

abstract class InjectionContainer {
  Future<void> init();
}

class InjectionContainerImpl implements InjectionContainer {
  final sl = GetIt.instance;

  @override
  Future<void> init() async {
    ///Features
    ///Signin
    //Bloc
    sl.registerFactory(() => SignInBloc(signInUser: sl()));

    //Usecases
    sl.registerLazySingleton(() => SignInUser(repository: sl()));

    //Repository
    sl.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImplementation(
        signinRemoteDataSource: sl(),
        secureStorage: sl(),
      ),
    );

    //Data
    sl.registerLazySingleton<SignInRemoteDataSource>(
      () => SignInRemoteDataSourceImpl(client: sl()),
    );

    ///Register
    // Bloc
    sl.registerFactory(() => RegisterBloc(registerUser: sl()));

    //Usecases
    sl.registerLazySingleton(() => RegisterUser(repository: sl()));

    //Repository
    sl.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImplementation(
        registerRemoteDataSource: sl(),
      ),
    );

    //Data
    sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(client: sl()),
    );

    ///Transfer
    // Bloc
    sl.registerFactory(() => TransferBloc(transferUser: sl(), secureStorage: sl()));

    //Usecases
    sl.registerLazySingleton(() => TransferUser(repository: sl()));

    //Repository
    sl.registerLazySingleton<TransferRepository>(
      () => TransferRepositoryImplementation(
        transferRemoteDataSource: sl(),
      ),
    );

    //Data
    sl.registerLazySingleton<TransferRemoteDataSource>(
      () => TransferRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
    );

    ///FileManager
    // Bloc
    sl.registerFactory(() => FileManagerBloc(
        authenticateFile: sl(), deleteFile: sl(), getFiles: sl()));

    //Usecases
    sl.registerLazySingleton(() => AuthenticateFile(repository: sl()));
    sl.registerLazySingleton(() => DeleteFile(repository: sl()));
    sl.registerLazySingleton(() => GetFiles(repository: sl()));

    //Repository
    sl.registerLazySingleton<FileManagerRepository>(
      () => FileManagerRepositoryImpl(fileManagerRemoteDataSource: sl()),
    );

    //Data
    sl.registerLazySingleton<FileManagerRemoteDataSource>(
      () => FileManagerRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
    );

    ///FileUploader
    // Bloc
    sl.registerFactory(() => FileUploaderBloc(uploadFileUseCase: sl()));

    //Usecases
    sl.registerLazySingleton(() => UploadFileUseCase(repository: sl()));

    //Repository
    sl.registerLazySingleton<FileUploadManagerRepository>(
      () => FileUploadManagerRepositoryImpl(fileManagerRemoteDataSource: sl()),
    );

    //Data
    sl.registerLazySingleton<FileUploadManagerRemoteDataSource>(
      () => FileUploadManagerRemoteDataSourceImpl(client: sl(), secureStorage: sl()),
    );
    

    ///Core
    sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(sl()));

    //Secure Storage
    sl.registerLazySingleton(() => const FlutterSecureStorage());

    //Dio
    sl.registerLazySingleton(Dio.new);
    sl.registerLazySingleton(() => DioClientMix(client: sl()));
    sl.registerLazySingleton<CustomHttpClient>(
      () => CustomHttpClientImpl(clientMix: sl()),
    );

    //Interceptor Manager
    sl.registerSingletonAsync(() async => InterceptorManager(
          dioClientMix: sl(),
          secureStorage: sl(),
        ));
  }
}
