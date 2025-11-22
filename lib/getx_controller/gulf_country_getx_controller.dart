import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tullana/api/api_settings.dart';
import 'package:tullana/models/gulf_country.dart';
import 'package:tullana/utils/helpers.dart';

class GulfCountryGetxController extends GetxController {
  var isLoading = false.obs;
  var countries = <GulfCountryData>[].obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchGulfCountries();
    super.onInit();
  }

  Future<void> fetchGulfCountries() async {
    isLoading.value = true;
    errorMessage.value = '';

    var url = Uri.parse(ApiSettings.gulfCountryList);
    // String token = UserGetStorage().getToken();

    // if (token.isEmpty) {
    //   errorMessage.value = "يرجى تسجيل الدخول لعرض الدول الخليجية.";
    //   isLoading.value = false;
    //   return;
    // }

    try {
      final response = await http.get(
        url,
        headers: {
          // 'Accept': 'application/json',
          // 'Authorization': token,
        },
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['status'] == true) {
        // قراءة قائمة الدول داخل data
        if (body["data"] != null && body["data"] is List) {
          countries.value = (body["data"] as List)
              .map((e) => GulfCountryData.fromJson(e))
              .toList();
        } else {
          countries.clear();
          errorMessage.value = "لا توجد بيانات دول خليجية.";
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = "انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى.";
        Helpers.showSnackBar(message: errorMessage.value, error: true);
      } else {
        errorMessage.value =
            body['message'] ?? "فشل في تحميل بيانات الدول الخليجية.";
        Helpers.showSnackBar(message: errorMessage.value, error: true);
      }
    } catch (e) {
      errorMessage.value = "حدث خطأ في الاتصال بالشبكة: $e";
      Helpers.showSnackBar(message: errorMessage.value, error: true);
    } finally {
      isLoading.value = false;
    }
  }
}
