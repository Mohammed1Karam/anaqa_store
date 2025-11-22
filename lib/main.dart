import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tullana/getx_controller/gulf_country_getx_controller.dart';
import 'package:tullana/getx_controller/user_api_controller.dart';
import 'package:tullana/screen/lunch/lunch_screen.dart';
import 'package:tullana/utils_lan/translations.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GulfCountryGetxController());
    Get.lazyPut(() => UserApiController());
  }
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الإشعارات
  await GetStorage.init();
  await initialConfig();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StorageService storage;

  @override
  void initState() {
    storage = Get.put(StorageService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String langCode = GetStorage().read('languageCode') ?? 'en';
    String countryCode = GetStorage().read('countryCode') ?? '';
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          builder: EasyLoading.init(),
          initialBinding: InitialBinding(),
          theme: ThemeData(fontFamily: 'Outfit'),
          translations: AppTranslations(),
          locale: Locale(langCode, countryCode),
          fallbackLocale: const Locale('en', ''),
          debugShowCheckedModeBanner: false,
          home: LunchScreen(),
        );
      },
    );
  }
}

OverlayEntry? _overlayEntry;

void showCustomLoading(BuildContext context) {
  _overlayEntry = OverlayEntry(
    builder: (_) => Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.3))),
        Center(
          child: Image.asset('images/loading2.gif', width: 90.w, height: 90.h),
        ),
      ],
    ),
  );

  Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
}

void hideCustomLoading() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}
