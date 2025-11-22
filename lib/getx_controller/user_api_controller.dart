import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tullana/api/api_settings.dart';
import 'package:tullana/models/user.dart';
import 'package:tullana/screen/auth/verification_code_screen.dart';
import 'package:tullana/screen/bottom_nav/main_screen.dart';
import '../../preferences/user_getstorage.dart';
import '../../utils/helpers.dart';

class UserApiController implements Helpers {
  var isLoading = false.obs;

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String countryCode,
    required String password,
    required String confirmPassword,
    required bool agreedWithTerms,
  }) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        countryCode.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        !agreedWithTerms) {
      Helpers.showSnackBar(
        message: "Please fill all required fields and agree with terms.",
        error: true,
      );
      return;
    }

    isLoading.value = true;
    var url = Uri.parse(ApiSettings.register);

    try {
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'country_code': countryCode,
        'password': password,
        'password_confirmation': confirmPassword,
        'agreed_with_terms': agreedWithTerms ? '1' : '0',
      };

      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedJson['status'] == true) {
        final userJson = decodedJson['user'];
        final token = decodedJson['token'];

        if (userJson != null && token != null) {
          await UserGetStorage().save(
            User.fromJson(userJson),
            token: token,
          );
        }

        Helpers.showSnackBar(
          message: decodedJson['message'] ?? 'Registration successful!',
        );
        Get.offAll(() => MainScreen());
      } else {
        if (decodedJson['errors'] != null) {
          decodedJson['errors'].forEach((key, value) {
            Helpers.showSnackBar(
              message: value[0]?.toString() ?? 'Error in field: $key',
              error: true,
            );
          });
        } else {
          Helpers.showSnackBar(
            message: decodedJson['message'] ?? 'Registration failed. Please try again.',
            error: true,
          );
        }
      }
    } catch (e) {
      Helpers.showSnackBar(
        message: 'An error occurred: Unable to connect to server.',
        error: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(
        message: "الرجاء إدخال بريدك الإلكتروني أو هاتفك وكلمة المرور",
        error: true,
      );
      // إرجاع فشل حقل فارغ
      return LoginResult(
        isSuccess: false,
        errorMessage: "الرجاء إدخال البريد الإلكتروني وكلمة المرور.",
      );
    }

    var url = Uri.parse(ApiSettings.login);
    LoadingOverlay.showCustomLoading();

    try {
      final body = {'email': email, 'password': password};

      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(decodedJson);

        if (userResponse.status == true && userResponse.user != null) {
          // حالة النجاح
          await UserGetStorage().save(
            userResponse.user!,
            token: userResponse.token ?? '',
          );

          Helpers.showSnackBar(
            message: userResponse.message ?? 'تم تسجيل الدخول بنجاح',
          );

          return LoginResult(isSuccess: true, user: userResponse.user);
        } else {
          // حالة الفشل (الخادم أرجع 200 ولكن الحالة هي false)
          final message = userResponse.message ?? 'فشل تسجيل الدخول';
          Helpers.showSnackBar(message: message, error: true);
          return LoginResult(isSuccess: false, errorMessage: message);
        }
      } else {
        // التعامل مع أخطاء الخادم (رمز الحالة ليس 200)
        String errorMessage =
            decodedJson['message']?.toString() ?? 'حدث خطأ في الخادم.';

        if (decodedJson['errors'] != null) {
          if (decodedJson['errors'] is Map) {
            errorMessage = (decodedJson['errors'] as Map).values
                .map(
                  (v) => (v is List) ? v[0]?.toString() ?? 'خطأ' : v.toString(),
                )
                .join('\n');
          }
        }

        Helpers.showSnackBar(message: errorMessage, error: true);
        return LoginResult(isSuccess: false, errorMessage: errorMessage);
      }
    } catch (e) {
      // التعامل مع استثناءات الشبكة
      final networkError = 'Error: $e. تأكد من اتصالك بالإنترنت.';
      Helpers.showSnackBar(message: networkError, error: true);
      return LoginResult(isSuccess: false, errorMessage: networkError);
    } finally {
      LoadingOverlay.hideCustomLoading();
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    if (email.isEmpty) {
      Helpers.showSnackBar(message: "Please enter your email", error: true);
      return false;
    }

    var url = Uri.parse(ApiSettings.forgot_password);
    LoadingOverlay.showCustomLoading();

    try {
      final body = {'email': email};

      var response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );

      final decodedJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final bool apiSuccess =
            decodedJson.containsKey('status') &&
            decodedJson['status'] == 'otp_sent';

        if (apiSuccess) {
          GetStorage().write('email', email);
          Helpers.showSnackBar(
            message:
                decodedJson['message'] ??
                'The reset code has been sent successfully.',
          );

          final String? otpCode = decodedJson['otp'] as String?;
          Get.to(() => VerificationCodeScreen(otp: otpCode));

          return true;
        } else {
          Helpers.showSnackBar(
            message:
                decodedJson['message'] ??
                'Failed to send OTP. Check your email.',
            error: true,
          );
          return false;
        }
      } else {
        if (decodedJson['errors'] != null) {
          (decodedJson['errors'] as Map).forEach((key, value) {
            Helpers.showSnackBar(
              message: value is List && value.isNotEmpty
                  ? value[0]
                  : 'Something went wrong',
              error: true,
            );
          });
        } else {
          Helpers.showSnackBar(
            message: decodedJson['message'] ?? 'Server error occurred.',
            error: true,
          );
        }
        return false;
      }
    } catch (e) {
      print(e);
      Helpers.showSnackBar(
        message: 'An unexpected error occurred: $e',
        error: true,
      );
      return false;
    } finally {
      LoadingOverlay.hideCustomLoading();
    }
  }

  //
  Future<bool> verifyOtp({required String email, required String token}) async {
    if (token.isEmpty || token.length != 4) {
      Helpers.showSnackBar(
        message: "Please enter the 4-digit code",
        error: true,
      );
      return false;
    }

    var url = Uri.parse(ApiSettings.verify);
    LoadingOverlay.showCustomLoading();

    try {
      final body = {'email': email, 'token': token};

      var response = await http.post(url, body: body);

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        GetStorage().write('email', email);
        GetStorage().write('token', token);
        Helpers.showSnackBar(
          message: decodedJson['message'] ?? "Verification successful",
        );
        return true;
      } else {
        Helpers.showSnackBar(
          message: decodedJson['message'] ?? "Something went wrong",
          error: true,
        );
        return false;
      }
    } catch (e) {
      Helpers.showSnackBar(message: 'An error occurred: $e', error: true);
      return false;
    } finally {
      LoadingOverlay.hideCustomLoading();
    }
  }

  //
  Future<bool> resetPassword({
    required String email,
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.isEmpty ||
        token.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Helpers.showSnackBar(message: "Please fill in all fields", error: true);
      return false;
    }

    var url = Uri.parse(ApiSettings.createNewPassword);
    LoadingOverlay.showCustomLoading();

    try {
      final body = {
        'email': email,
        'token': token,
        'password': password,
        'confirm_password': confirmPassword,
      };

      final response = await http.put(
        url,
        headers: {'Accept': 'application/json'},
        body: body,
      );

      final decodedJson = jsonDecode(response.body);
      print('Request Body: $body');
      print('Status Code: ${response.statusCode}');
      print('Response: $decodedJson');

      if (response.statusCode == 200) {
        if (decodedJson['status']['success'] == true) {
          if (decodedJson['user'] != null &&
              decodedJson['user']['s_access_token'] != null) {
            await UserGetStorage().save(
              User.fromJson(decodedJson['user']),
              token: decodedJson['user']['s_access_token'],
            );
          }

          Get.offAll(() => MainScreen());

          Helpers.showSnackBar(
            message:
                decodedJson['status']['message'] ??
                'Password reset successfully',
          );
          return true;
        } else {
          Helpers.showSnackBar(
            message: decodedJson['status']['message'] ?? 'An error occurred',
            error: true,
          );
          return false;
        }
      } else {
        Helpers.showSnackBar(
          message: 'An error occurred, please try again later',
          error: true,
        );
        return false;
      }
    } catch (e) {
      print(e);
      Helpers.showSnackBar(message: "Error: $e", error: true);
      return false;
    } finally {
      LoadingOverlay.hideCustomLoading();
    }
  }
}
