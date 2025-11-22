class GulfCountry {
  bool? status;
  List<GulfCountryData>? data;

  GulfCountry({this.status, this.data});

  GulfCountry.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((v) => GulfCountryData.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class GulfCountryData {
  String? countryName;
  String? countryCode;
  String? dialCode;
  String? currencyCode;
  double? exchangeRate;

  GulfCountryData({
    this.countryName,
    this.countryCode,
    this.dialCode,
    this.currencyCode,
    this.exchangeRate,
  });

  GulfCountryData.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    countryCode = json['country_code'];
    dialCode = json['dial_code'];
    currencyCode = json['currency_code'];

    /// تحويل قيمة exchange_rate مهما كان نوعها (int / string / double)
    var rate = json['exchange_rate'];
    if (rate is int) {
      exchangeRate = rate.toDouble();
    } else if (rate is String) {
      exchangeRate = double.tryParse(rate);
    } else {
      exchangeRate = rate?.toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "country_name": countryName,
      "country_code": countryCode,
      "dial_code": dialCode,
      "currency_code": currencyCode,
      "exchange_rate": exchangeRate,
    };
  }
}
