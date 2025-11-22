import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/app_colors.dart';
import '../widget/my_text.dart';
import 'ar.dart';
import 'en.dart';


/*
 *   Future<bool> setLanguage(String codeLang) async{
    return await _sharedPreferences.setString("CodeLang", codeLang);
  }

  String get codeLang => _sharedPreferences.getString("CodeLang") ?? "en";
}*/
class StorageService extends GetxService {
  late String? languageCode;
  late String? countryCode;

  Future<StorageService> init() async {
    await GetStorage.init();
    languageCode = await GetStorage().read('languageCode');
    countryCode = await GetStorage().read('countryCode');
    return this;
  }

  void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
  // DBService, ...
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController(), permanent: true);
    Get.put(StorageService(), permanent: true);
  }
}

class LanguageController extends GetxController {
  final storage = Get.find<StorageService>();
  final RxString locale = Get.locale.toString().obs;

  String get codeLang => GetStorage().read('languageCode') ?? "en";

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'description': 'English'
    },
    'ar_SA': {
      'languageCode': 'ar',
      'countryCode': 'SA',
      'description': 'Arabic'
    },
    // 'pt_BR': {
    //   'languageCode': 'pt',
    //   'countryCode': 'BR',
    //   'description': 'Português'
    // },
  };
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar': ar,
        // 'pt_BR': {
        //   'hello': 'Alo Mundo',
        //   'welcome': 'Bem-vindo',
        // },
      };
}

final storage = Get.find<StorageService>();
final RxString locale = Get.locale.toString().obs;
final langCon = Get.put(LanguageController());

void updateLocale(String? key) {
  final String languageCode = langCon.optionsLocales[key]['languageCode'];
  final String countryCode = langCon.optionsLocales[key]['countryCode'];
  // Update App
  Get.updateLocale(Locale(languageCode, countryCode));
  // Update obs
  locale.value = Get.locale.toString();
  // Update storage
  storage.write('languageCode', languageCode);
  storage.write('countryCode', countryCode);
}

class LanguageDropDown extends GetView<LanguageController> {
  LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => DropdownButton<String>(
        borderRadius: BorderRadius.circular(15.r),
        value: controller.locale.value,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation:  6,
        // focusColor: AppColors.Gren_COLOR,
        style: TextStyle(
            color: Colors.black,
            fontFamily:'Outfit',
            fontWeight: FontWeight.w700,
            fontSize: 15.sp),
        underline: Container(
          height: 2.h,
          color: Colors.black
        ),
        onChanged: (var newValue) {
          updateLocale(newValue);
          // print(newValue.toString());
        },
        items: controller.optionsLocales.entries.map((item) {
          return DropdownMenuItem<String>(
            value: item.key,
            child: MyText(
                text: item.value['description'],
                fontSize: 15.sp,
                maxLines: 1,
                decoration: TextDecoration.overline,
                fontWeight:
                FontWeight.w700,
                color: Colors.black ) ,
          );
        }).toList(),
      ),
    );
  }
}

class LanguageMenu extends GetView<LanguageController> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.language),
      offset: Offset(0, 30),
      itemBuilder: (context) => controller.optionsLocales.entries.map((item) {
        return PopupMenuItem(
          value: item.key,
          child: Text(item.value['description']),
        );
      }).toList(),
      onSelected: (newValue) {
        updateLocale(newValue);
        // print('sadadadadwadadadadawd');
        // print(newValue.toString());
      },
    );
  }
}
