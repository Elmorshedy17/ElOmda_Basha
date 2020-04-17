import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:momentoo/features/about_us/about_manager.dart';
import 'package:momentoo/features/address_book/addressBook_manager.dart';
import 'package:momentoo/features/ads/ads_manager.dart';
import 'package:momentoo/features/edit_address/dropdown_data.dart';
import 'package:momentoo/features/help_support/get_help_support/_manger.dart';
import 'package:momentoo/features/help_support/helpSupportValidation_manager.dart';
import 'package:momentoo/features/home/autoComplete_manager.dart';
import 'package:momentoo/features/home/home_manager.dart';
import 'package:momentoo/features/near_by/getAddress_manager.dart';
import 'package:momentoo/features/new_address/dropdown_data.dart';
import 'package:momentoo/features/product_details/productDetailsCounter_manager.dart';
import 'package:momentoo/features/profile/_manager.dart';
import 'package:momentoo/features/product_details/productDetails_manager.dart';
import 'package:momentoo/features/search/search_manager.dart';
import 'package:momentoo/features/settings/notificationSwitch_manager.dart';
import 'package:momentoo/features/sign_in/signInValidation_manager.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/features/sign_up/sign_up_manger.dart';

import 'package:momentoo/features/storeDetails/storeDetails_manager.dart';
import 'package:momentoo/features/trending_products/trendinfProduct_manager.dart';
import 'package:momentoo/features/trending_stores/trendingStore_manager.dart';
import 'package:momentoo/shared/services/connection_service.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';
import 'package:momentoo/shared/services/fcm/pushNotification_service.dart';
import 'package:momentoo/shared/services/localizations/app_language.dart';
import 'package:momentoo/shared/services/location_service.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/permission_service.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/services/share_servce/shareService.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance);
  // Setup PermissionsService.
  locator.registerLazySingleton<PermissionsService>(() => PermissionsService());
  // Setup ConnectionCheckerService.
  locator.registerLazySingleton<ConnectionCheckerService>(
      () => ConnectionCheckerService());
  // Setup LanguageManager
  locator.registerLazySingleton<AppLanguage>(() => AppLanguage());
  // SignInValidationManager
  locator.registerLazySingleton<SignInValidationManager>(
      () => SignInValidationManager());
  // SignUpValidationManager
  locator.registerLazySingleton<SignUpValidationManager>(
      () => SignUpValidationManager());
  // PushNotificationService
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  // Setup LocationService
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
  // NotificationSwitchManager
  locator.registerLazySingleton<NotificationSwitchManager>(
      () => NotificationSwitchManager());
  // AdsManager
  locator.registerLazySingleton<AdsManager>(() => AdsManager());
  // HomeManager
  locator.registerLazySingleton<HomeManager>(() => HomeManager());
  locator.registerLazySingleton<AboutManager>(() => AboutManager());
  locator.registerLazySingleton<RegisterManager>(() => RegisterManager());
  locator.registerLazySingleton<ProfileManager>(() => ProfileManager());
  locator.registerLazySingleton<AddressesManager>(() => AddressesManager());
  locator.registerLazySingleton<DrobDownBloc>(() => DrobDownBloc());
  locator.registerLazySingleton<EditDrobDownBloc>(() => EditDrobDownBloc());
  locator.registerLazySingleton<ContactUsManager>(() => ContactUsManager());
  // TrendingStoreManager
  locator.registerLazySingleton<TrendingStoreManager>(
      () => TrendingStoreManager());
  // TrendingProductsManager
  locator.registerLazySingleton<TrendingProductsManager>(
      () => TrendingProductsManager());
  // AutoCompleteManager
  locator
      .registerLazySingleton<AutoCompleteManager>(() => AutoCompleteManager());
  // TextEditingController Search
  locator.registerLazySingleton<TextEditingController>(
      () => TextEditingController());
  // SearchManager
  locator.registerLazySingleton<SearchManager>(() => SearchManager());
  // StoreDetailsManager
  locator
      .registerLazySingleton<StoreDetailsManager>(() => StoreDetailsManager());
  // ShareService
  locator.registerLazySingleton<ShareService>(() => ShareService());
  // ProductDetailsManager
  locator.registerLazySingleton<ProductDetailsManager>(
      () => ProductDetailsManager());
//  locator.registerLazySingleton<StoreDetailsManager>(() => StoreDetailsManager());
}
