import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tullana/models/user.dart';
import 'package:tullana/screen/auth/login_screen.dart';

class UserGetStorage {
  static final UserGetStorage _instance = UserGetStorage._();
  final box = GetStorage();

  factory UserGetStorage() => _instance;

  UserGetStorage._();

  /// 🟢 تهيئة التخزين
  Future<void> initPreferences() async {
    await GetStorage.init();
  }

  /// 🟢 حفظ بيانات المستخدم بعد تسجيل الدخول مع token
  Future<void> save(User user, {String? token}) async {
    await box.write('logged_in', true);
    await box.write('user', user.toJson());
    if (token != null) {
      await box.write('token', token);
    }
  }

  /// 🟢 قراءة كائن User من التخزين
  User? getUser() {
    final data = box.read('user');
    if (data != null) {
      return User.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  /// 🟢 حالة تسجيل الدخول
  bool get isLoggedIn => box.read('logged_in') ?? false;

  /// 🟢 تسجيل الخروج
  Future<void> logout() async {
    await box.erase(); // يمسح كل شيء نهائيًا
    await Get.offAll(() => LoginScreen());
  }

  /// 🟢 قراءة التوكن
  String getToken() {
    final token = box.read('token');
    return token != null ? "Bearer $token" : "";
  }

  String getTokenRaw() {
    final token = box.read('token');
    return token ?? "";
  }

  /// 🟢 قراءة الاسم الكامل
  String getFullName() {
    final user = getUser();
    return "${user?.firstName ?? ""} ${user?.lastName ?? ""}".trim();
  }

  /// 🟢 قراءة الايميل
  String getEmail() => getUser()?.email ?? "";

  /// 🟢 قراءة الصورة
  String getImage() => getUser()?.image ?? "";

  /// 🟢 قراءة الـ ID
  int getId() => getUser()?.id ?? 0;

 }
