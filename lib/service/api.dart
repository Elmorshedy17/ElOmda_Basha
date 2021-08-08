import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:medicine/service/api_contsants.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/check_code_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/login_api_bloc.dart';
import 'package:medicine/src/blocs/api_blocs/notifications_manger.dart';
import 'package:medicine/src/blocs/api_blocs/show_service_bloc.dart';
import 'package:medicine/src/blocs/change_password_bloc.dart';
import 'package:medicine/src/blocs/contact_admin_bloc.dart';
import 'package:medicine/src/blocs/firebase_token_bloc.dart';
import 'package:medicine/src/blocs/forget_password_bloc.dart';
import 'package:medicine/src/blocs/home_page_bloc.dart';
import 'package:medicine/src/blocs/new_order_bloc.dart';
import 'package:medicine/src/blocs/signUp_bloc.dart';
import 'package:medicine/src/blocs/status_message_bloc.dart';
import 'package:medicine/src/blocs/sumPricesBloc.dart';
import 'package:medicine/src/blocs/update_profile.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/models/api_models/common/active_code.dart';
import 'package:medicine/src/models/api_models/common/check_email_model.dart';
import 'package:medicine/src/models/api_models/common/device_id_model.dart';
import 'package:medicine/src/models/api_models/common/login_model.dart';
import 'package:medicine/src/models/api_models/common/logout_model.dart';
import 'package:medicine/src/models/api_models/common/register_model.dart';
import 'package:medicine/src/models/api_models/common/resend_active_code_model.dart';
import 'package:medicine/src/models/api_models/common/reset_password_checkCode_model.dart';
import 'package:medicine/src/models/api_models/common/store_contact_us.dart';
import 'package:medicine/src/models/api_models/common/update_password_model.dart';
import 'package:medicine/src/models/api_models/common/user_profileUpdate_model.dart';
import 'package:medicine/src/models/api_models/common/user_profile_model.dart';
import 'package:medicine/src/models/api_models/data/all_countries.dart';
import 'package:medicine/src/models/api_models/data/show_cart_model.dart';
import 'package:medicine/src/models/delivery_models/all_notification_show_model.dart';
import 'package:medicine/src/models/delivery_models/change_order_status.dart';
import 'package:medicine/src/models/delivery_models/delegate_finish_order_model.dart';
import 'package:medicine/src/models/delivery_models/notification_delete_model.dart';
import 'package:medicine/src/models/delivery_models/send_service_request.dart';
import 'package:medicine/src/models/delivery_models/send_transfer_model.dart';
import 'package:medicine/src/models/delivery_models/show_all_delegates_orders.dart';
import 'package:medicine/src/models/delivery_models/show_delegate_order.dart';
import 'package:medicine/src/models/delivery_models/show_new_delegates_orders.dart';
import 'package:medicine/src/models/delivery_models/show_services_model.dart';
import 'package:medicine/src/models/delivery_models/update_order_model.dart';
import 'package:medicine/src/models/packages_show_model.dart';
import 'package:medicine/src/models/super_visor_marketers/Update_allCart_itemsModel.dart';
import 'package:medicine/src/models/super_visor_marketers/add_to_cart_model.dart';
import 'package:medicine/src/models/super_visor_marketers/filter_service_model.dart';
import 'package:medicine/src/models/super_visor_marketers/home_model.dart';
import 'package:medicine/src/models/super_visor_marketers/money_request_model.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_marketer_orders_model.dart';
import 'package:medicine/src/models/super_visor_marketers/show_all_markters_model.dart';
import 'package:medicine/src/models/super_visor_marketers/show_cities_delgates.dart';
import 'package:medicine/src/models/super_visor_marketers/show_order_model.dart';
import 'package:medicine/src/models/super_visor_marketers/show_package_marketers.dart';
import 'package:medicine/src/models/super_visor_marketers/store_order_model.dart';
import 'package:medicine/src/models/super_visor_marketers/store_gifts_model.dart';
import 'package:medicine/src/models/super_visor_marketers/update_and_delete_cart_item_model.dart';
import 'package:medicine/src/new_code/delivery_edit_cart/MODEL.dart';
import 'package:medicine/src/new_code/delivery_edit_cart/MODEL.dart';

var GlobalUserType = locator<PrefsService>().userType == null ? locator<UserTypeBloc>().currentUserType:locator<PrefsService>().userType;
var GlobalUserId = locator<PrefsService>().saveUserId == null? locator<UserIdBloc>().currentUserId.toString() : locator<PrefsService>().saveUserId.toString();

class ApiService {
//  locator<PrefsService>().appLanguage == "en";

  static Future<LoginModel> login() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData =
//    FormData.fromMap({"email_phone": email, "password": password});

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Login_VAR',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "email": "${locator<LoginApiBloc>().currentEmailApi.trim()}",
          "password": "${locator<LoginApiBloc>().currentPassword}",
          "user_type": "${locator<UserTypeBloc>().currentUserType}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "device_type": "$platform"
        },
      );
      return LoginModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////// logout ////////////
  static Future<LoginModel> logout() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData =
//    FormData.fromMap({"email_phone": email, "password": password});

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$log_Out',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//          "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "device_type": "$platform"
        },
      );
      return LoginModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////// SIGN UP / REGISTER ////////////

  static Future<RegisterModel> Register(dropFirstVal, dropSecVal) async {
    final dio = Dio();

    String codeId = locator<UserTypeBloc>().currentUserType == 'marketer'
        ? locator<SignUpBloc>().currentSupervisorCode
        : "";

    String platform;

    var counteryIdo = locator<UserTypeBloc>().currentUserType == "delegate" ? locator<NewOrderBloc>().currentCounteryId : "";
    var cityIdo = locator<UserTypeBloc>().currentUserType == "delegate" ? locator<NewOrderBloc>().currentCityId : "";


    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData =
//    FormData.fromMap({"email_phone": email, "password": password});

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Register_VAR',
        data: {
//          "lang":locator<PrefsService>().appLanguage,
//          "email": "${locator<LoginApiBloc>().currentEmailApi}",
//          "password": "${locator<LoginApiBloc>().currentPassword}",
//          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
//          "device_type": "$platform",
          //
          "lang":locator<PrefsService>().appLanguage,
          "first_name": "${locator<SignUpBloc>().currentName}",
          "last_name": "${locator<SignUpBloc>().currentSecondName}",
          "email": "${locator<SignUpBloc>().currenEmail.trim()}",
          "phone": "${locator<SignUpBloc>().currentMobile}",
          "phone_code": "$dropFirstVal",
          "whatsapp": "${locator<SignUpBloc>().currentWhatsapp}",
          "whatsapp_code": "$dropSecVal",
          "user_type": "${locator<UserTypeBloc>().currentUserType}",
          "password": "${locator<SignUpBloc>().currentPassword}",
          "benfit_type":
              "${locator<SignUpBloc>().currentradioButtom != null ? locator<SignUpBloc>().currentradioButtom : "commission"}",
          "id_code": "$codeId",
          "country_id": "$counteryIdo",
          "city_id": "$cityIdo",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return RegisterModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////// CheckCode ////////////

  static Future<ActiveCodeModel> ActiveCode(currentText) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData =
//    FormData.fromMap({"email_phone": email, "password": password});

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Active_Code',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "code": "$currentText",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ActiveCodeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////// Logout ////////////

  static Future<LogOutModel> LogOut() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData =
//    FormData.fromMap({"email_phone": email, "password": password});

    //    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Active_Code',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "device_type": "$platform",
        },
      );
      return LogOutModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// User Profile ////////////

  static Future<UserProfileModel> UserProfile() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    //    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$USER_PROFILE',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString().toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return UserProfileModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// Update Password ////////////

  static Future<UpdatePasswordModel> UpdatePassword() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$UPDATE_PASSWORD',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "old_password": "${locator<ChangePasswordBloc>().currentOldPassword}",
          "new_password": "${locator<ChangePasswordBloc>().currentNewPassword}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return UpdatePasswordModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// ResendActiveCode ////////////

  static Future<ResendActiveCodeModel> ResendActiveCode() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Resend_Active_Code',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
        },
      );
      return ResendActiveCodeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// reset password/check_code ////////////

  static Future<ResetPasswordCheckCodeModel> ResetPasswordCheckCode(
      currentText) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Resend_Active_Code',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
////              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
//          "code": "$currentText",
//          "password": "123456",
//          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
//          "device_type": "$platform",
        },
      );
      return ResetPasswordCheckCodeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// forget password/check_email ////////////

  static Future<ForgetPasswordCheckEmailModel>
      ForgetPasswordCheckEmail() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Check_Email',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "email": "${locator<ForgetPasswordBloc>().currentState.toString().trim()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ForgetPasswordCheckEmailModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// StoreContactUs ////////////

  static Future<StoreContactUsModel> StoreContactUs() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Store_Contact_Us',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "email": "${locator<ContactAdminBloc>().currentState.toString().trim()}",
          "message": "${locator<ContactAdminBloc>().currentTextArea}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return StoreContactUsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// update profile////////////

  static Future<UserProfileUpdateModel> UserProfileUpdate(
      firstName,
      secondName,
      phone,
      whatsapp,
      SelectedImage,SelectedImagePath,email,dropFirstVal,dropSecVal,accountNumber) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    if(SelectedImagePath != null){

    }
    FormData formData = SelectedImagePath != null? FormData.fromMap({
      "lang":locator<PrefsService>().appLanguage,
      "user_id":GlobalUserId,
//      "${locator<UserIdBloc>().currentUserId.toString().toString()}",
      "first_name": "$firstName",
      "last_name": "$secondName",
      "email": "$email",
      // "email": "${locator<UpdateProfileBloc>().currenEmail}",
      "phone": "$phone",
      "phone_code": "$dropFirstVal",
      "whatsapp": "$whatsapp",
      "whatsapp_code": "$dropSecVal",
      //      "avatar": "$SelectedImage",
      "avatar": await MultipartFile.fromFile("$SelectedImagePath",filename: "$SelectedImagePath"),
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
      "notify_send":locator<PrefsService>().notifySend,
      "account_number":"$accountNumber",
      "country_id": locator<AllOrdersFilterBloc>().currentCounteryId,
    }):
    FormData.fromMap({
      "lang":locator<PrefsService>().appLanguage,
      "user_id":GlobalUserId,
//      "${locator<UserIdBloc>().currentUserId.toString().toString()}",
//       "first_name": "${locator<UpdateProfileBloc>().currentName == ""?locator<PrefsService>().userNameProfile:locator<UpdateProfileBloc>().currentName}",
//       "last_name": "${locator<UpdateProfileBloc>().currentSecondName == ""?locator<PrefsService>().userLastName:locator<UpdateProfileBloc>().currentSecondName}",
//       "email": "${email.toString().trim() == ""?locator<PrefsService>().userEmailProfile:email.toString().trim()}",
      "first_name": "$firstName",
      "last_name": "$secondName",
      "email": "$email",
      // "email": "${locator<UpdateProfileBloc>().currenEmail}",
      // "phone": "${locator<UpdateProfileBloc>().currentMobile == ""?locator<PrefsService>().userPhoneProfile:locator<UpdateProfileBloc>().currentMobile}",
      // "phone_code": "$dropFirstVal",
      // "whatsapp": "${locator<UpdateProfileBloc>().currentWhatsapp == "" ? locator<PrefsService>().userWhatsAppProfile:locator<UpdateProfileBloc>().currentWhatsapp}",
      // "whatsapp_code": "$dropSecVal",
      "phone": "$phone",
      "phone_code": "$dropFirstVal",
      "whatsapp": "$whatsapp",
      "whatsapp_code": "$dropSecVal",
      //      "avatar": "$SelectedImage",
//      "avatar": await MultipartFile.fromFile("$SelectedImagePath",filename: "$SelectedImagePath"),
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
      "notify_send":locator<PrefsService>().notifySend,
      "account_number":"$accountNumber",
    "country_id": locator<AllOrdersFilterBloc>().currentCounteryId,

    });
//     FormData formData = SelectedImagePath != null? FormData.fromMap({
//       "lang":locator<PrefsService>().appLanguage,
//       "user_id":GlobalUserId,
// //      "${locator<UserIdBloc>().currentUserId.toString().toString()}",
//       "first_name": "${(locator<UpdateProfileBloc>().currentName == "" || locator<UpdateProfileBloc>().currentName == null)?locator<PrefsService>().userNameProfile:locator<UpdateProfileBloc>().currentName}",
//       "last_name": "${(locator<UpdateProfileBloc>().currentSecondName == "" || locator<UpdateProfileBloc>().currentSecondName == null)?locator<PrefsService>().userLastName:locator<UpdateProfileBloc>().currentSecondName}",
//       "email": "${(email.toString().trim() == ""||email.toString().trim() == null)?locator<PrefsService>().userEmailProfile:email.toString().trim()}",
//       // "email": "${locator<UpdateProfileBloc>().currenEmail}",
//       "phone": "${(locator<UpdateProfileBloc>().currentMobile == null || locator<UpdateProfileBloc>().currentMobile == "")?locator<PrefsService>().userPhoneProfile:locator<UpdateProfileBloc>().currentMobile}",
//       "phone_code": "$dropFirstVal",
//       "whatsapp": "${(locator<UpdateProfileBloc>().currentWhatsapp == null || locator<UpdateProfileBloc>().currentWhatsapp == "") ? locator<PrefsService>().userWhatsAppProfile:locator<UpdateProfileBloc>().currentWhatsapp}",
//       "whatsapp_code": "$dropSecVal",
//       //      "avatar": "$SelectedImage",
//       "avatar": await MultipartFile.fromFile("$SelectedImagePath",filename: "$SelectedImagePath"),
//       "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
//       "notify_send":locator<PrefsService>().notifySend
//     }):
//     FormData.fromMap({
//       "lang":locator<PrefsService>().appLanguage,
//       "user_id":GlobalUserId,
// //      "${locator<UserIdBloc>().currentUserId.toString().toString()}",
// //       "first_name": "${locator<UpdateProfileBloc>().currentName == ""?locator<PrefsService>().userNameProfile:locator<UpdateProfileBloc>().currentName}",
// //       "last_name": "${locator<UpdateProfileBloc>().currentSecondName == ""?locator<PrefsService>().userLastName:locator<UpdateProfileBloc>().currentSecondName}",
// //       "email": "${email.toString().trim() == ""?locator<PrefsService>().userEmailProfile:email.toString().trim()}",
//       "first_name": "${(locator<UpdateProfileBloc>().currentName == "" || locator<UpdateProfileBloc>().currentName == null)?locator<PrefsService>().userNameProfile:locator<UpdateProfileBloc>().currentName}",
//       "last_name": "${(locator<UpdateProfileBloc>().currentSecondName == "" || locator<UpdateProfileBloc>().currentSecondName == null)?locator<PrefsService>().userLastName:locator<UpdateProfileBloc>().currentSecondName}",
//       "email": "${(email.toString().trim() == ""||email.toString().trim() == null)?locator<PrefsService>().userEmailProfile:email.toString().trim()}",
//       // "email": "${locator<UpdateProfileBloc>().currenEmail}",
//       // "phone": "${locator<UpdateProfileBloc>().currentMobile == ""?locator<PrefsService>().userPhoneProfile:locator<UpdateProfileBloc>().currentMobile}",
//       // "phone_code": "$dropFirstVal",
//       // "whatsapp": "${locator<UpdateProfileBloc>().currentWhatsapp == "" ? locator<PrefsService>().userWhatsAppProfile:locator<UpdateProfileBloc>().currentWhatsapp}",
//       // "whatsapp_code": "$dropSecVal",
//       "phone": "${(locator<UpdateProfileBloc>().currentMobile == null || locator<UpdateProfileBloc>().currentMobile == "")?locator<PrefsService>().userPhoneProfile:locator<UpdateProfileBloc>().currentMobile}",
//       "phone_code": "$dropFirstVal",
//       "whatsapp": "${(locator<UpdateProfileBloc>().currentWhatsapp == null || locator<UpdateProfileBloc>().currentWhatsapp == "") ? locator<PrefsService>().userWhatsAppProfile:locator<UpdateProfileBloc>().currentWhatsapp}",
//       "whatsapp_code": "$dropSecVal",
//       //      "avatar": "$SelectedImage",
// //      "avatar": await MultipartFile.fromFile("$SelectedImagePath",filename: "$SelectedImagePath"),
//       "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
//       "notify_send":locator<PrefsService>().notifySend
//     });
    try {
      Response response = await dio.post(
        '$BASE_URL$User_Profile_Update',
        data:formData
//        {
//          "lang":locator<PrefsService>().appLanguage,
//          "user_id":
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
//          "first_name": "${locator<UpdateProfileBloc>().currentName}",
//          "last_name": "${locator<UpdateProfileBloc>().secondname}",
//          "email": "$email",
//          // "email": "${locator<UpdateProfileBloc>().currenEmail}",
//          "phone": "${locator<UpdateProfileBloc>().currentMobile}",
//          "phone_code": "${locator<UpdateProfileBloc>().currentPhoneCode}",
//          "whatsapp": "${locator<UpdateProfileBloc>().currentWhatsapp}",
//          "whatsapp_code":
//              "${locator<UpdateProfileBloc>().currentWhatsappCode}",
//    //      "avatar": "$SelectedImage",
//          "avatar": await MultipartFile.fromFile("$SelectedImage",filename: "${SelectedImage.path}"),
//        },
      );
      return UserProfileUpdateModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  //////////////////////////////////////////////  Super Visor Marketers   ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
  ////////// homepage ////////////

  static Future<HomeModel> HomePageApi() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$home_markters_superMarkters',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id": "$GlobalUserId",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return HomeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// FilterService ////////////

  static Future<FilterServiceModel> FilterService(
    firstPriceRange,
    endPriceRange,
    firstAmount,
    endAmount,
  ) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Filter_Service',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "start_price": "${firstPriceRange.toString()}",
          "end_price": "${endPriceRange.toString()}",
          "start_quantity": "${firstAmount.toString()}",
          "end_quantity": "${endAmount.toString()}",
          "title": "${locator<HomePageBloc>().currenSearch}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return FilterServiceModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// Add to cart ////////////

  static Future<AddToCardModel> AddToCart(id) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Add_To_Cart',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "section_id": "$id",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return AddToCardModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// show cart ////////////

  static Future<ShowCartModel> ShowCart() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Show_Cart',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ShowCartModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// Update & Delete Cart Item ////////////

  static Future<UpdateDeleteModel> UpdateDelteCart(
      quantity, cartId, multipli) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Update_And_Delete_cart',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "cart_id": "$cartId",
          "count": "$quantity",
          "total": "$multipli",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return UpdateDeleteModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// SendMoneyRequest ////////////

  static Future<MoneyRequestModel> MoneyRequest(amount) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Send_Money_Request',
        data: {
          "lang":locator<PrefsService>().appLanguage,
"user_id":GlobalUserId,
          "message": "$amount",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return MoneyRequestModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// Countery & City ////////////

  static Future<AllCountries> AllCountriesAndCities() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Countery_And_City',
        data: {
          "lang":locator<PrefsService>().appLanguage,
        },
      );
      return AllCountries.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// StoreOrder ////////////

  static Future<StoreOrderModel> StoreOrder( name, phoneNumber, whatsAppNumber, email, adrLocation,notes) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }


    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Store_Order',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
          "country_id": "${locator<NewOrderBloc>().currentCounteryId}",
          "city_id": "${locator<NewOrderBloc>().currentCityId}",
          "name": "$name",
          "phone": " $phoneNumber",
          "whatsapp": "$whatsAppNumber",
          "email": "${email.toString().trim()}",
//          "lat": "${locator<NewOrderBloc>().currentLatLocation}",
//          "lng": "${locator<NewOrderBloc>().currentlongLocation}",
          "lat": "",
          "lng": "",
          "address": "$adrLocation",
          "date": "${locator<NewOrderBloc>().currentdateTime == null ? "" : locator<NewOrderBloc>().currentdateTime.toString().toLowerCase()}",
//          "time": "${locator<NewOrderBloc>().currentdateTime}",
          // it can be nullable we just need put date & time on the date filed her we cant send it empty
          "total": "${locator<SumPricesBloc>().currentSumPrices}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "notes":"$notes"

        },
      );
      return StoreOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// show all order ////////////

  static Future<ShowAllMarketerOrdersModel> ShowAllMarketerOrders() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));


var showUrl = "show-all-marketer-orders?page=${locator<AllOrdersFilterBloc>().currentPageControllerValue}";

    try {
      Response response = await dio.post(
        '$BASE_URL$showUrl',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
          "type": "${locator<AllOrdersFilterBloc>().currentAllOrdersFilter}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "order_id": locator<AllOrdersFilterBloc>().orderIdFilterBloc.value,
          "country_id": locator<AllOrdersFilterBloc>().currentCounteryId,
          "city_id": locator<AllOrdersFilterBloc>().currentCityId,
          // "provider_id": locator<AllOrdersFilterBloc>().providerIdFilterBloc.value,
          "phone": locator<AllOrdersFilterBloc>().phoneFilterBloc.value,
          "start_date": locator<AllOrdersFilterBloc>().startDateFilterBloc.value,
          "end_date": locator<AllOrdersFilterBloc>().endDateFilterBloc.value,

        },
      );
      return ShowAllMarketerOrdersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// UpdateAllCartModels ////////////

  static Future<UpdateAllCartItemsModel> UpdateAllCartItems(all) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Update_All_Cart_Items',
        data: {
          "lang":locator<PrefsService>().appLanguage,
"user_id":GlobalUserId,
          "items": "$all",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return UpdateAllCartItemsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// /// // // // / / // / / / now this is delivery apies
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
  ////////// ShowNewDelegatesOrders => its delivery home page ////////////

  static Future<ShowNewDelegatesOrdersModel> ShowNewDelegatesOrders(
      UserId) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Show_New_Delegates_Orders',
        data: {
//         "user_id"    : 176,
          "user_id":GlobalUserId,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ShowNewDelegatesOrdersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  ////////// Transfere Money ////////////

  static Future<SendTransferModel> SendTransfer(image,path,money,name) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    FormData formData = path != null?  FormData.fromMap({
      "user_id":GlobalUserId,
      "name": "$name",
      "price": "$money",
      "image": await MultipartFile.fromFile("$path",filename: "$path"),
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

//          "file": await MultipartFile.fromFile("./text.txt",filename: "imageUpload"),
//          "image": await MultipartFile.fromFile("$path",filename: "$path"),
    }):FormData.fromMap({
      "user_id":GlobalUserId,
      "name": "$name",
      "price": "$money",
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

//          "file": await MultipartFile.fromFile("./text.txt",filename: "imageUpload"),
//          "image": await MultipartFile.fromFile("$path",filename: "$path"),
    });

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Send_Transfer',
        data: formData,
//        {
//          "user_id":GlobalUserId,
//          "name": "$name",
//          "price": "$money",
////          "file": await MultipartFile.fromFile("./text.txt",filename: "imageUpload"),
////          "image": await MultipartFile.fromFile("$path",filename: "$path"),
//        },
      );
      return SendTransferModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }


  }

//  ////////////////////////////////////////////////////////////////////////////////
/////////////////////////////Performing a POST request////for CheckOut////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//  // Post checkoutmodel
//  static Future<SendTransferModel> SendTransfer(image,path,money,name) async {
//
//    final dio = Dio();
//
//    String platform;
//
//    if (Platform.isAndroid) {
//      platform = 'android';
//    } else if (Platform.isIOS) {
//      platform = 'ios';
//    }
//
//    FormData formData = FormData.fromMap({
//      "doctor_id": id,
//      "date": date,
//      "time": time,
//      "pay_type": payType,
//      "name": name,
//      "phone": phone,
//      "insurance_id": insuranceId
//    });
//
//    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));
//
//    try {
//      Response response = await dio.post(
//        '$BASE_URL$CHECKOUT_VAR',
//        data: formData,
//        //formData,
//        options: Options(
//          headers: {
//            LANG_HEADER: locator<PrefsService>().appLanguage,
//            PLATFORM_HEADER: platform,
//            FIRE_BASE_TOKEN_HEADER:
//            locator<FirebaseTokenBloc>().currentFirebaseToken,
//            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
//          },
//        ),
//      );
//      return CheckoutModel.fromJson(response.data);
//    } catch (error, stacktrace) {
//      print("Exception occured: $error stackTrace: $stacktrace");
//      return null;
//    }
//  }





//
//  static Future<SendTransferModel> SendTransfer(image,path,money,name) async {
//    final dio = Dio();
//
//    String platform;
//
//    if (Platform.isAndroid) {
//      platform = 'android';
//    } else if (Platform.isIOS) {
//      platform = 'ios';
//    }
//
//    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));
//
//    try {
//      Response response = await dio.post(
//        '$BASE_URL$Send_Transfer',
//        data: {
//          "user_id":GlobalUserId,
//          "name": "$name",
//          "price": "$money",
////          "file": await MultipartFile.fromFile("./text.txt",filename: "imageUpload"),
////          "image": await MultipartFile.fromFile("$path",filename: "$path"),
//        },
//      );
//      return SendTransferModel.fromJson(response.data);
//    } catch (error, stacktrace) {
//      print("Exception occured: $error stackTrace: $stacktrace");
//      return null;
//    }
//  }


/////////////////////////////////////////////////////////////////////////////////////
  ////////// Show Services ////////////

  static Future<ShowServicesModel> ShowServices() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Show_Services',
        data: {
          "user_id": GlobalUserId,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,


        },
      );
      return ShowServicesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }





/////////////////////////////////////////////////////////////////////////////////////
  ////////// Send_Service_Request ////////////

  static Future<SendServiceRequestModel> SendServiceRequest(items) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Send_Service_Request',
        data: {
          "user_id":GlobalUserId,
          "items": "$items",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return SendServiceRequestModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }








/////////////////////////////////////////////////////////////////////////////////////
  ////////// show-delegate_order ////////////

  static Future<ShowDelegateOrderModel> ShowDelegateOrder(id) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Show_Delegate_Order',
        data: {
          "order_id": id,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

//          "user_id":GlobalUserId,
//          "items": "$items",
        },
      );
      return ShowDelegateOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }




/////////////////////////////////////////////////////////////////////////////////////
  ////////// update-order  for delivery ////////////

//   static Future<UpdateOrderModel> UpdateOrderDelivery(itemId , quantity,tottalIncreasedQuantity) async {
//     final dio = Dio();
//     String platform;
//     if (Platform.isAndroid) {
//       platform = 'android';
//     } else if (Platform.isIOS) {
//       platform = 'ios';
//     }
//     dio.interceptors.add(LogInterceptor(
//       responseBody: true,
//       request: true,
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//     ));
//     try {
//       Response response = await dio.post(
//         '$BASE_URL$Update_Order',
//         data: {
//           "order_item_id": itemId,
//           "count": int.parse(quantity),
//           "tottal": tottalIncreasedQuantity,
//           "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
//
// //          "order_item_id": 25,
// //          "count":6,
//         },
//       );
//       return UpdateOrderModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       print("Exception occured: $error stackTrace: $stacktrace");
//       return null;
//     }
//   }


/////////////////////////////////////////////////////////////////////////////////////
  ////////// change-order-status ////////////

  static Future<ChangeOrderStatusModel> ChangeOrderStatus(id,msg) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Change_Order_Status',
        data: {
          "order_id": id,
          "user_id":GlobalUserId,
          "status": "${locator<StatusMessageBloc>().currentStatus}",
          "delivery":"",
          "message":"$msg - ${formattedDate.toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ChangeOrderStatusModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


/////////////////////////////////////////////////////////////////////////////////////
  ////////// show-all-delegates-orders ////////////

  static Future<ShowAllDelegatesOrdersModel> ShowAllDelegatesOrders() async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {


    //   user_id:
    //   type:   => cancel,has_provider,in_way,finish,current_order,finish_order
    // filter:
    // order_id:
    // country_id:
    // city_id:
    // market_id:
    // phone:
    // start_date:
    // end_date:
      var showUrl = "show-all-delegates-orders?page=${locator<AllOrdersFilterBloc>().currentPageControllerValue}";

      Response response = await dio.post(
        '$BASE_URL$showUrl',
        // '$BASE_URL$Show_All_Delegates_Orders',
        data: {
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "lang":locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
         // "filter":"${locator<AllOrdersFilterBloc>().currentAllOrdersFilter}",
         // "type": "${locator<AllOrdersFilterBloc>().currentAllTypsOrdersFilter}",
         // "order_id":"",
         // "country_id":"country_id",
         // "city_id":"city_id",
         // "market_id":"market_id",
         // "phone":"phone",
         // "start_date":"start_date",
         // "end_date":"end_date"
          "type": "${locator<AllOrdersFilterBloc>().currentAllOrdersFilter}",
          "order_id": locator<AllOrdersFilterBloc>().orderIdFilterBloc.value,
          "country_id": locator<AllOrdersFilterBloc>().currentCounteryId,
          "city_id": locator<AllOrdersFilterBloc>().currentCityId,
          // "provider_id": locator<AllOrdersFilterBloc>().providerIdFilterBloc.value,
          "phone": locator<AllOrdersFilterBloc>().phoneFilterBloc.value,
          "start_date": locator<AllOrdersFilterBloc>().startDateFilterBloc.value,
          "end_date": locator<AllOrdersFilterBloc>().endDateFilterBloc.value,




        },
      );
      return ShowAllDelegatesOrdersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


/////////////////////////////////////////////////////////////////////////////////////
  ////////// show-all-delegates-orders ////////////

  static Future<DelegateFinishOrderModel> DelegateFinishOrder(orderID,msg,delivery) async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Delegate_Finish_Order',
        data: {
          "order_id": orderID,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "delivery":delivery,
          "message":msg

        },
      );
      return DelegateFinishOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }




/////////////////////////////////////////////////////////////////////////////////////
  ////////// Show_All_Marketers ////////////

  static Future<ShowAllMarketersModel> ShowAllMarketers() async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Show_All_Marketers',
        data: {
          "user_id":GlobalUserId,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ShowAllMarketersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }






/////////////////////////////////////////////////////////////////////////////////////
  ////////// packages/show ////////////

  static Future<PackagesShowModel> PackagesShow() async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Packages_Show',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return PackagesShowModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }




/////////////////////////////////////////////////////////////////////////////////////
  ////////// ShowPackageMarketers ////////////

  static Future<ShowPackageMarketersModel> ShowPackageMarketers(id) async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Packages_Markters_Show',
        data: {
          "user_id":GlobalUserId,
          "lang":locator<PrefsService>().appLanguage,
          "package_id": "$id",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ShowPackageMarketersModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }







/////////////////////////////////////////////////////////////////////////////////////
  ////////// packages/show ////////////

  static Future<StoreGiftsModel> StoreGifts(id,all) async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Store_Gifts',
        data: {
          "package_id": "$id",
          "user_ids": "$all",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return StoreGiftsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }







/////////////////////////////////////////////////////////////////////////////////////
  ////////// update DeviceId (firebase token ) ////////////

  static Future<DeviceIdModel> DeviceId() async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Device_Firebase_Token',
        data: {
          "lang": locator<PrefsService>().appLanguage,
          "user_id":GlobalUserId,
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "device_type": "$platform",

        },
      );
      return DeviceIdModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }









/////////////////////////////////////////////////////////////////////////////////////
  ////////// show notifications ////////////

  static Future<AllNotificationShowModel> AllNotificationShow() async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$All_Notification_Show',
        data: {
          "user_id":GlobalUserId,
          "page":locator<NotificationsBloc>().currentPageControllerValue
        },
      );
      return AllNotificationShowModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }









/////////////////////////////////////////////////////////////////////////////////////
  ////////// delete notifications ////////////

  static Future<NotificationDeleteModel> NotificationDelete(notificationID) async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Dotification_Delete',
        data: {
          "notification_id": "$notificationID",


        },
      );
      return NotificationDeleteModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }











/////////////////////////////////////////////////////////////////////////////////////
  ////////// Show Order & Order status ////////////

  static Future<ShowOrderModel> ShowOrder(orderId) async {
    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Show_Order',
        data: {
          "order_id": "$orderId",


        },
      );
      return ShowOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }





  static Future<DeliveryUpdateOrderModel> DeliveryUpdateOrder(
      orderId,
      items,
      countryId,
      cityId,
      name,
      phone,
      whatsapp,
      // email,
      address,
      total
      ) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$UpdateOrder',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "order_id": "$orderId",
          "items": "$items",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "country_id":"$countryId",
          "city_id":"$cityId",
          "name":"$name",
          "phone":"$phone",
          "whatsapp":"$whatsapp",
          // "email":"$email",
          "address": "$address",
          "total":"$total",

        },
      );
      return DeliveryUpdateOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
/////////

  static Future<ResetPasswordCheckCodeModel> ResetPasswordCheckCodeCode(
      currentText,newPassword,userId) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$Check_Code',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id":userId,
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
         "code": "$currentText",
         "password": "$newPassword",
         "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
         "device_type": "$platform",
        },
      );
      return ResetPasswordCheckCodeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


  /////////


  static Future<ChangeOrderStatusModel> AgreeChangeOrderStatus(id,message) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Change_Order_Status',
        data: {
          "order_id": id,
          "user_id":GlobalUserId,
          "status": "agree",
          "delivery":"",
          "message":"$message - ${formattedDate.toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ChangeOrderStatusModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
///////////
//// cancel order ()delivery

  static Future<ChangeOrderStatusModel> cancelOrderStatus(id,msg,delivery) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    final dio = Dio();
    String platform;
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    try {
      Response response = await dio.post(
        '$BASE_URL$Change_Order_Status',
        data: {
          "order_id": id,
          "user_id":GlobalUserId,
          "status": "${locator<StatusMessageBloc>().currentStatus}",
          "delivery":delivery,
          "message":"$msg - ${formattedDate.toString()}",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ChangeOrderStatusModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }



  /////////////////////////////////////////////////////////////////////////////////////
  ////////// update profile////////////

  static Future<UserProfileUpdateModel> UserProfileUpdateNotification(dropFirstVal,dropSecVal) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    FormData formData = FormData.fromMap({
      "lang":locator<PrefsService>().appLanguage,
      "user_id":GlobalUserId,
       "first_name": "${locator<PrefsService>().userNameProfile}",
      "last_name": "${locator<PrefsService>().userLastName}",
      "email": "${locator<PrefsService>().userEmailProfile}",
      "phone": "${locator<PrefsService>().userPhoneProfile}",
      "phone_code": "$dropFirstVal",
      "whatsapp": "${locator<PrefsService>().userWhatsAppProfile}",
      "whatsapp_code": "$dropSecVal",
       "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
      "notify_send":locator<PrefsService>().notifySend
    });

    try {
      Response response = await dio.post(
          '$BASE_URL$User_Profile_Update',
          data:formData
//        {
//          "lang":locator<PrefsService>().appLanguage,
//          "user_id":
//              "${locator<UserIdBloc>().currentUserId.toString().toString()}",
//          "first_name": "${locator<UpdateProfileBloc>().currentName}",
//          "last_name": "${locator<UpdateProfileBloc>().secondname}",
//          "email": "$email",
//          // "email": "${locator<UpdateProfileBloc>().currenEmail}",
//          "phone": "${locator<UpdateProfileBloc>().currentMobile}",
//          "phone_code": "${locator<UpdateProfileBloc>().currentPhoneCode}",
//          "whatsapp": "${locator<UpdateProfileBloc>().currentWhatsapp}",
//          "whatsapp_code":
//              "${locator<UpdateProfileBloc>().currentWhatsappCode}",
//    //      "avatar": "$SelectedImage",
//          "avatar": await MultipartFile.fromFile("$SelectedImage",filename: "${SelectedImage.path}"),
//        },
      );
      return UserProfileUpdateModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


  /////////////////////////////////////////////////////////////////////////////////////
  ////////// ShowServicesModel////////////

  static Future<ShowServicesModel> ShowServicesApi() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    FormData formData = FormData.fromMap({
      "lang":locator<PrefsService>().appLanguage,
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
      "user_id":GlobalUserId,
      "start_date":locator<ShowServiceBloc>().startDateFilterBloc.value,
      "end_date":locator<ShowServiceBloc>().endDateFilterBloc.value,
      // "country_id":"$counteryId"

    });

    try {
      Response response = await dio.post(
          '$BASE_URL$SHOWSERVICE',
          data:formData

      );
      return ShowServicesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }



  ///////////////


  static Future<DeliveryUpdateOrderModel> UpdateMarkterOrder(orderId,items,countryId,cityId,name,phone,whatsapp,email,address,total) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$UPDATEORDERMarkter',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "order_id": "$orderId",
          "items": "$items",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
          "country_id":"$countryId",
          "city_id":"$cityId",
          "name":"$name",
          "phone":"$phone",
          "whatsapp":"$whatsapp",
          "email":"$email",
          "address": "$address",
          "total":"$total",

        },
      );
      return DeliveryUpdateOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  static Future<DeliveryUpdateOrderModel> ResendCanceledORder(orderId,countryId,cityId,name,phone,whatsapp,email,address,total) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$RESENDORDER',
        data: {
      "lang":locator<PrefsService>().appLanguage,
      "order_id": "$orderId",
      "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,
      "country_id":"$countryId",
      "city_id":"$cityId",
      "name":"$name",
      "phone":"$phone",
      "whatsapp":"$whatsapp",
      "email":"$email",
      "address": "$address",
      "total":"$total",

        },
      );
      return DeliveryUpdateOrderModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }



  //////////////////////
  static Future<ShowCitiesDelegatesModel> ShowCitiesDelegatesApi() async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$SHOWCITIESDELGATES',
        data: {
          "lang":locator<PrefsService>().appLanguage,
          "user_id": "$GlobalUserId",
          "device_id": locator<FirebaseTokenBloc>().currentFirebaseToken,

        },
      );
      return ShowCitiesDelegatesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


}



//////////////////////

