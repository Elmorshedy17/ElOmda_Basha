import 'package:get_it/get_it.dart';
import 'package:momentoo/features/help_support/helpSupportValidation_manager.dart';
import 'package:momentoo/features/near_by/getAddress_manager.dart';
import 'package:momentoo/features/product_details/productDetailsCounter_manager.dart';
import 'package:momentoo/features/sign_in/signInValidation_manager.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';
import 'package:momentoo/shared/services/fcm/pushNotification_service.dart';
import 'package:momentoo/shared/services/localizations/app_language.dart';
import 'package:momentoo/shared/services/location_service.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/permission_service.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance);
  // Setup PermissionsService.
  locator.registerLazySingleton<PermissionsService>(() => PermissionsService());
  // Setup LanguageManager
  locator.registerLazySingleton<AppLanguage>(() => AppLanguage());
  // SignInValidationManager
  locator.registerLazySingleton<SignInValidationManager>(
      () => SignInValidationManager());
  // SignUpValidationManager
  locator.registerLazySingleton<SignUpValidationManager>(
      () => SignUpValidationManager());
  // Home Page Controller
//  locator.registerLazySingleton<PageController>(
//      () => PageController(initialPage: 0, keepPage: false));
  // PushNotificationService
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  // LocationService
  locator.registerLazySingleton<LocationService>(() => LocationService());
  // ManuallyMapManager
  locator.registerLazySingleton<GetAddressManager>(() => GetAddressManager());
  // FcmTokenManager
  locator.registerLazySingleton<FcmTokenManager>(() => FcmTokenManager());
  // ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());
  // HelpSupportValidationManager
  locator.registerLazySingleton<HelpSupportValidationManager>(
      () => HelpSupportValidationManager());
  // ProductDetailsCounterManager
  locator.registerLazySingleton<ProductDetailsCounterManager>(
      () => ProductDetailsCounterManager());
}
