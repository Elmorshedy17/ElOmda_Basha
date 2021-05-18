import 'package:get_it/get_it.dart';
import 'package:medicine/localizations/app_language.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/check_code_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/delivery_coasts_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/show_service_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/update_cart_bloc.dart';
import 'package:medicine/src/blocs/carousel_indicator.dart';
import 'package:medicine/src/blocs/delivery_order_update_details_bloc.dart';
import 'package:medicine/src/blocs/delivery_orders_list.dart';
import 'package:medicine/src/blocs/filter_screen_bloc.dart';
import 'package:medicine/src/blocs/firebase_token_bloc.dart';
import 'package:medicine/src/blocs/home_page_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/login_api_bloc.dart';
import 'package:medicine/src/blocs/change_password_bloc.dart';
import 'package:medicine/src/blocs/contact_admin_bloc.dart';
import 'package:medicine/src/blocs/forget_password_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/local_firebase_bloc.dart';
import 'package:medicine/src/blocs/my_account_switch_bloc.dart';
import 'package:medicine/src/blocs/my_orders_blocs.dart';
import 'package:medicine/src/blocs/new_order_bloc.dart';
import 'package:medicine/src/blocs/signIn_bloc.dart';
import 'package:medicine/src/blocs/signUp_bloc.dart';
import 'package:medicine/src/blocs/status_message_bloc.dart';
import 'package:medicine/src/blocs/stepper_bloc.dart';
import 'package:medicine/src/blocs/sumPricesBloc.dart';
import 'package:medicine/src/blocs/update_profile.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_IMPLEMENTATION = true;

int count;

void setupLocator() async {
  // Register services
  // Register models


  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance);
  locator.registerLazySingleton<AppLanguage>(() => AppLanguage());
  // Forms setting //
  locator.registerLazySingleton<SignUpBloc>(() => SignUpBloc());
  locator.registerLazySingleton<ShowServiceBloc>(() => ShowServiceBloc());
  locator.registerLazySingleton<SignInBloc>(() => SignInBloc());
  locator.registerLazySingleton<LoginApiBloc>(() => LoginApiBloc());
  locator.registerLazySingleton<UserTypeBloc>(() => UserTypeBloc());
  locator.registerLazySingleton<ChangePasswordBloc>(() => ChangePasswordBloc());
  locator.registerLazySingleton<SwitchNotyBloc>(() => SwitchNotyBloc());
  locator.registerLazySingleton<ForgetPasswordBloc>(() => ForgetPasswordBloc());
  locator.registerLazySingleton<ContactAdminBloc>(() => ContactAdminBloc());
  locator.registerLazySingleton<UpdateProfileBloc>(() => UpdateProfileBloc());
  locator.registerLazySingleton<HomePageBloc>(() => HomePageBloc());
  locator.registerLazySingleton<FilterScreenBloc>(() => FilterScreenBloc());
  locator.registerLazySingleton<UpdateCartModel>(() => UpdateCartModel());
  locator.registerLazySingleton<UserIdBloc>(() => UserIdBloc());
  locator.registerLazySingleton<NewOrderBloc>(() => NewOrderBloc());
  locator.registerLazySingleton<SumPricesBloc>(() => SumPricesBloc());
  locator.registerLazySingleton<AllOrdersFilterBloc>(() => AllOrdersFilterBloc());
  locator.registerLazySingleton<DeliveryOrdersListBloc>(() => DeliveryOrdersListBloc());
  locator.registerLazySingleton<DeliveryCostaBloc>(() => DeliveryCostaBloc());
  locator.registerLazySingleton<DliveryUpdateDetailsBloc>(() => DliveryUpdateDetailsBloc());
  locator.registerLazySingleton<StatusMessageBloc>(() => StatusMessageBloc());
  locator.registerLazySingleton<StepperBloc>(() => StepperBloc());
  locator.registerLazySingleton<MyOrdersBloc>(() => MyOrdersBloc());
  locator.registerLazySingleton<CarouselIndicatorBloc>(() => CarouselIndicatorBloc());
  locator.registerLazySingleton<LocalFirebaseBloc>(() => LocalFirebaseBloc());
  locator.registerLazySingleton<FirebaseTokenBloc>(() => FirebaseTokenBloc());
  locator.registerLazySingleton<IsLoadingManager>(() => IsLoadingManager());
}