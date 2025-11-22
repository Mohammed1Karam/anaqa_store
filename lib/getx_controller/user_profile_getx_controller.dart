// import 'dart:convert';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:logger/logger.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
// import 'package:rent_app/api/api_settings.dart';
// import 'package:rent_app/getx_controller/user_api_controller.dart';
// import 'package:rent_app/models/user.dart';
// import 'package:rent_app/preferences/user_getstorage.dart';
// import 'package:rent_app/utils/helpers.dart';
//
// class UserProfileGetxController extends GetxController {
//   var isLoading = false.obs;
//   var userProfile = User().obs;
//   var isOnline = false.obs;
//   final RxString errorMessage = ''.obs;
//
//   Future<void> fetchUserProfile() async {
//     isLoading.value = true;
//
//     try {
//       final response = await http.get(
//         Uri.parse("${ApiSettings.profile}"),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': UserGetStorage().getToken(),
//         },
//       );
//
//       final body = jsonDecode(response.body);
//
//       if (response.statusCode == 200 && body['status']?['success'] == true) {
//         if (body['user'] != null) {
//           userProfile.value = User.fromJson(body['user']);
//         }
//       } else {
//         Helpers.showSnackBar(
//           message: body['status']?['message'] ?? "Failed to fetch user profile",
//           error: true,
//         );
//       }
//     } catch (e) {
//       Helpers.showSnackBar(message: "Error: $e", error: true);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<bool> updateProfile({
//     required String sName,
//     required String sIdNumber,
//     required String sMobile,
//     required String sMobileWhats,
//     String? sEmail,
//     XFile? sAvatar,
//     XFile? s_id_image,
//   }) async {
//     final User? oldUser = UserGetStorage().getUser();
//
//     if (oldUser == null) {
//       Helpers.showSnackBar(
//         message: "فشل تحديث الملف: بيانات المستخدم غير متوفرة محلياً.",
//         error: true,
//       );
//       return false;
//     }
//
//     final finalSName = sName.isNotEmpty ? sName : oldUser.sName;
//     final finalSIdNumber = sIdNumber.isNotEmpty ? sIdNumber : oldUser.sIdNumber;
//     final finalSMobile = sMobile.isNotEmpty ? sMobile : oldUser.sMobile;
//     final finalSMobileWhats = sMobileWhats.isNotEmpty
//         ? sMobileWhats
//         : oldUser.sMobileWhats;
//     final finalSEmail = (sEmail != null && sEmail.isNotEmpty)
//         ? sEmail
//         : oldUser.sEmail;
//
//     if (finalSName == null || finalSMobile == null) {
//       Helpers.showSnackBar(
//         message: "يرجى إدخال الاسم ورقم الجوال على الأقل.",
//         error: true,
//       );
//       return false;
//     }
//
//     var url = Uri.parse(ApiSettings.update_profile);
//     LoadingOverlay.showCustomLoading();
//
//     try {
//       var request = http.MultipartRequest('POST', url);
//
//       request.headers['Accept'] = 'application/json';
//       request.headers['Authorization'] = UserGetStorage().getToken();
//
//       request.fields['s_name'] = finalSName;
//       request.fields['s_id_number'] = finalSIdNumber ?? '';
//       request.fields['s_mobile'] = finalSMobile;
//       request.fields['s_mobile_whats'] = finalSMobileWhats ?? '';
//
//       if (finalSEmail != null) {
//         request.fields['s_email'] = finalSEmail;
//       }
//
//       if (sAvatar != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath('s_avatar', sAvatar.path),
//         );
//       }
//  if (s_id_image != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath('s_id_image', s_id_image.path),
//         );
//       }
//
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       final decodedJson = jsonDecode(response.body);
//       print(response.statusCode);
//       if (response.statusCode == 200 &&
//           decodedJson['status']?['success'] == true) {
//         fetchUserProfile();
//         // final userResponse = UserResponse.fromJson(decodedJson);
//
//         // userProfile.value = userResponse.user!;
//
//         // await UserGetStorage().save(
//         //   userResponse.user!,
//         //   token: userResponse.user!.sAccessToken,
//         // );
//
//         Helpers.showSnackBar(
//           message:
//              // decodedJson['status']?['message'] ??
//               'تم تحديث الملف الشخصي بنجاح!',
//         );
//
//         return true;
//       } else {
//         if (decodedJson['errors'] != null) {
//           decodedJson['errors'].forEach((key, value) {
//             Helpers.showSnackBar(
//               message: value[0] ?? 'حدث خطأ في الحقل ($key)',
//               error: true,
//             );
//             print(value[0] );
//
//           });
//         } else {
//           print(decodedJson['status']?['message']);
//           Helpers.showSnackBar(
//             message:
//                 decodedJson['status']?['message'] ??
//                 'فشل التحديث، حاول مرة أخرى.',
//             error: true,
//           );
//         }
//         return false;
//       }
//     } catch (e) {
//       Helpers.showSnackBar(
//         message: 'حدث خطأ: لا يمكن الاتصال بالخادم. $e',
//         error: true,
//       );
//       return false;
//     } finally {
//       LoadingOverlay.hideCustomLoading();
//     }
//   }
//
//
//   Future<bool> changePassword({
//     required String currentPassword,
//     required String newPassword,
//     required String newPasswordConfirmation,
//   }) async {
//     // 1. التحقق من الحقول الإجبارية
//     if (currentPassword.isEmpty || newPassword.isEmpty || newPasswordConfirmation.isEmpty) {
//       Helpers.showSnackBar(
//         message: "يرجى إدخال كلمة المرور الحالية والجديدة وتأكيدها.",
//         error: true,
//       );
//       return false;
//     }
//
//     // 2. التحقق من تطابق كلمة المرور الجديدة وتأكيدها
//     if (newPassword != newPasswordConfirmation) {
//       Helpers.showSnackBar(
//         message: "كلمة المرور الجديدة وتأكيدها غير متطابقتين.",
//         error: true,
//       );
//       return false;
//     }
//
//     // 3. إعداد الطلب
//     var url = Uri.parse(ApiSettings.changePassword); // يجب تعريف هذا الثابت في ApiSettings
//     LoadingOverlay.showCustomLoading();
//
//     try {
//       var request = http.MultipartRequest('POST', url);
//
//       // المصادقة (Authorization Header)
//       request.headers['Accept'] = 'application/json';
//       // 💡 يُفضل استخدام Bearer إذا كان الخادم يتوقع ذلك (كما نوقش سابقًا)
//       request.headers['Authorization'] = 'Bearer ${UserGetStorage().getToken()}';
//
//       // إضافة حقول form-data المطلوبة (s_password, s_new_password, s_new_password_confirmation)
//       request.fields['s_password'] = currentPassword;
//       request.fields['s_new_password'] = newPassword;
//       request.fields['s_new_password_confirmation'] = newPasswordConfirmation;
//
//       // 4. إرسال الطلب ومعالجة الاستجابة
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       final decodedJson = jsonDecode(response.body);
//
//       if (response.statusCode == 200 &&
//           decodedJson['status']?['success'] == true) {
//
//         Helpers.showSnackBar(
//           message: decodedJson['status']?['message'] ?? 'تم تغيير كلمة المرور بنجاح.',
//         );
//
//         return true;
//       } else {
//         // معالجة أخطاء التحقق والأخطاء العامة
//         if (decodedJson['errors'] != null) {
//           decodedJson['errors'].forEach((key, value) {
//             Helpers.showSnackBar(
//               message: value[0] ?? 'حدث خطأ في الحقل ($key)',
//               error: true,
//             );
//           });
//         } else {
//           Helpers.showSnackBar(
//             message: decodedJson['status']?['message'] ?? 'فشل تغيير كلمة المرور، حاول مرة أخرى.',
//             error: true,
//           );
//         }
//         return false;
//       }
//     } catch (e) {
//       Helpers.showSnackBar(
//         message: 'حدث خطأ: لا يمكن الاتصال بالخادم.',
//         error: true,
//       );
//       return false;
//     } finally {
//       LoadingOverlay.hideCustomLoading();
//     }
//   }
// }
