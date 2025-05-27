import 'package:dio/dio.dart';
import 'package:easyfy_care_patient/features/account_screen/data/datasource/accout_datasource.dart';
import 'package:easyfy_care_patient/features/account_screen/data/repository/account_repository_impl.dart';
import 'package:easyfy_care_patient/features/account_screen/domain/repository/account_repository.dart';
import 'package:easyfy_care_patient/features/account_screen/domain/usecase/account_usecase.dart';
import 'package:easyfy_care_patient/features/account_screen/presentation/bloc/account_bloc.dart';
import 'package:easyfy_care_patient/features/booking_appointment_screen/presentation/bloc/appointment_bloc.dart';
import 'package:easyfy_care_patient/features/chat_screen/presentation/bloc/chat_bloc.dart';
import 'package:easyfy_care_patient/features/form_screens/presentation/bloc/form_bloc.dart';
import 'package:easyfy_care_patient/features/home_screen/data/datasource/home_datasource.dart';
import 'package:easyfy_care_patient/features/home_screen/data/repository/home_respository_impl.dart';
import 'package:easyfy_care_patient/features/home_screen/domain/repository/home_repository.dart';
import 'package:easyfy_care_patient/features/home_screen/domain/usecase/home_usecase.dart';
import 'package:easyfy_care_patient/features/home_screen/presentation/bloc/home_bloc_bloc.dart';
import 'package:easyfy_care_patient/features/notification_screen/data/datasource/notification_datasource.dart';
import 'package:easyfy_care_patient/features/notification_screen/data/repository/notification_repository_impl.dart';
import 'package:easyfy_care_patient/features/notification_screen/domain/repository/notification_repository.dart';
import 'package:easyfy_care_patient/features/notification_screen/domain/usecase/notification_usecase.dart';
import 'package:easyfy_care_patient/features/notification_screen/presentation/bloc/notification_bloc.dart';
import 'package:easyfy_care_patient/features/onboarding_screen/presentation/bloc/onboarding_bloc.dart';
import 'package:easyfy_care_patient/features/report_screen/presentation/bloc/report_bloc.dart';
import 'package:easyfy_care_patient/features/search_doctor_screen/data/datasource/doctor_datasource.dart';
import 'package:easyfy_care_patient/features/search_doctor_screen/data/repository/doctor_repository.dart';
import 'package:easyfy_care_patient/features/search_doctor_screen/domain/repository/doctor_repository.dart';
import 'package:easyfy_care_patient/features/search_doctor_screen/domain/usecase/doctor_usecase.dart';
import 'package:easyfy_care_patient/features/search_doctor_screen/presentation/bloc/search_doctor_bloc.dart';
import 'package:easyfy_care_patient/features/splash_screen/data/datasource/splash_datasource.dart';
import 'package:easyfy_care_patient/features/splash_screen/data/repository/splash_repository_impl.dart';
import 'package:easyfy_care_patient/features/splash_screen/domain/repository/splash_repository.dart';
import 'package:easyfy_care_patient/features/splash_screen/domain/usecase/splash_usecase.dart';
import 'package:easyfy_care_patient/features/splash_screen/presentation/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../features/otp_screen/data/datasources/otp_remote_data_source.dart';
import '../../../features/otp_screen/data/repository/otp_repository_impl.dart';
import '../../../features/otp_screen/domain/repositories/otp_repository.dart';
import '../../../features/otp_screen/domain/usecases/otp_usecase.dart';
import '../../../features/otp_screen/presentation/bloc/otp_bloc.dart';
import '../../../features/register_screen/data/datasource/register_remote_datasource.dart';
import '../../../features/register_screen/data/repository/register_repository_impl.dart';
import '../../../features/register_screen/domain/repository/register_repository.dart';
import '../../../features/register_screen/domain/usecase/register_usecase.dart';
import '../../../features/register_screen/presentation/bloc/reg_bloc.dart';
import 'api_client.dart';
import 'notification_services.dart';

final GetIt getIt = GetIt.instance;
void serviceLocator() {
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  // Registering Dio instance for API calls
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Registering ApiClient, passing Dio as a dependency
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  //splash screen

  // Data sources
  getIt.registerLazySingleton<SplashDatasource>(
    () => SplashDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(datasource: getIt<SplashDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<SplashUsecase>(
    () => SplashUsecase(repository: getIt<SplashRepository>()),
  );

  // BLoCs
  getIt.registerFactory<SplashBloc>(
    () => SplashBloc(useCase: getIt<SplashUsecase>()),
  );

  // OTP Screen DI

  // Data sources
  getIt.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(datasource: getIt<OtpRemoteDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<OtpUseCase>(
    () => OtpUseCase(getIt<OtpRepository>()),
  );

  // BLoCs
  getIt.registerFactory<OtpBloc>(
    () => OtpBloc(otpUseCase: getIt<OtpUseCase>()),
  );

  //onboarding screen

  // BLoCs
  getIt.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(),
  );

//
  getIt.registerFactory<FormBloc>(
    () => FormBloc(),
  );

  //appointment screen

  // BLoCs
  getIt.registerFactory<AppointmentBloc>(
    () => AppointmentBloc(),
  );

  // Register Screen DI

  // Data sources
  getIt.registerLazySingleton<RegisterRemoteDatasource>(
    () => RegisterRemoteDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(datasource: getIt<RegisterRemoteDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<RegisterRepository>()),
  );

  // BLoCs
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
        registerUseCase: getIt<RegisterUseCase>(),
        notificationService: getIt<NotificationService>()),
  );

  // Doctor Search Screen DI

  // Data sources
  getIt.registerLazySingleton<DoctorDatasource>(
    () => DoctorDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(datasource: getIt<DoctorDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<DoctorUsecase>(
    () => DoctorUsecase(repository: getIt<DoctorRepository>()),
  );

  // BLoCs
  getIt.registerFactory<SearchDoctorBloc>(
    () => SearchDoctorBloc(doctorUsecase: getIt<DoctorUsecase>()),
  );

// Home Screen DI

  // Data sources
  getIt.registerLazySingleton<HomeDatasource>(
    () => HomeDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(datasource: getIt<HomeDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<HomeUsecases>(
    () => HomeUsecases(repository: getIt<HomeRepository>()),
  );

  // BLoCs
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
        usecases: getIt<HomeUsecases>(),
        notificationService: getIt<NotificationService>()),
  );

// Account Screen DI

  // Data sources
  getIt.registerLazySingleton<AccountDatasource>(
    () => AccountDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(datasource: getIt<AccountDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<AccountUsecase>(
    () => AccountUsecase(repository: getIt<AccountRepository>()),
  );

  // BLoCs
  getIt.registerFactory<AccountBloc>(
    () => AccountBloc(
      usecase: getIt<AccountUsecase>(),
    ),
  );

  // Notification Screen DI

  // Data sources
  getIt.registerLazySingleton<NotificationDatasource>(
    () => NotificationDatasource(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<NotificationRepository>(
    () =>
        NotificationRepositoryImpl(datasource: getIt<NotificationDatasource>()),
  );

  // Use cases
  getIt.registerLazySingleton<NotificationUsecase>(
    () => NotificationUsecase(repository: getIt<NotificationRepository>()),
  );

  // BLoCs
  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      usecase: getIt<NotificationUsecase>(),
    ),
  );

// chat  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // BLoCs
  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(),
  );

//ReportBloc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // BLoCs
  getIt.registerFactory<ReportBloc>(
    () => ReportBloc(),
  );
}
