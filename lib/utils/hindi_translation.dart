import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HindiTranslation {
  static Future<TransliterationResponse?> transliterate(
    String inputString,
    Languages languageCode,
  ) async {
    TransliterationResponse _transliterationResponse =
        new TransliterationResponse();
    String srcLanCode = Utility.getLanguageCode(Languages.ENGLISH);
    String descLanCode = Utility.getLanguageCode(languageCode);
    String lowerCaseSrcString = inputString.toLowerCase();
    final transliterationURL =
        '${Utility.transliterationBaseURL}?langpair=$srcLanCode|$descLanCode&text=$lowerCaseSrcString';
    try {
      Response _response = await http.get(Uri.parse(transliterationURL));
      List<TransliterationResponse> _transliterationResponseList =
          transliterationResponseFromJson(_response.body.toString());
      _transliterationResponse.transliterationSuggestions =
          _transliterationResponseList.first.transliterationSuggestions;
      _transliterationResponse.sourceString =
          _transliterationResponseList.first.sourceString;
      return _transliterationResponse;
    } catch (e) {
      print('Exception : $e');
    }
    return null;
  }
}

/// converts json to PODO class
List<TransliterationResponse> transliterationResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<TransliterationResponse>.from(
      jsonData.map((x) => TransliterationResponse.fromJson(x)));
}

/// converts back from PODO to json String
String transliterationResponseToJson(List<TransliterationResponse> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

/// PODO class
class TransliterationResponse {
  String sourceString;
  List<String> transliterationSuggestions;

  TransliterationResponse({
    this.sourceString = '',
    this.transliterationSuggestions = const [],
  });

  factory TransliterationResponse.fromJson(Map<String, dynamic> json) =>
      new TransliterationResponse(
        sourceString: json["ew"],
        transliterationSuggestions:
            new List<String>.from(json["hws"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ew": sourceString,
        "hws": new List<String>.from(transliterationSuggestions.map((x) => x)),
      };
}

class Utility {
  /// Base URL
  static final String transliterationBaseURL =
      'https://www.google.com/transliterate/all';

  /// Converts Enums to Google Language Codes
  static String getLanguageCode(Languages languageCode) {
    switch (languageCode) {
      case Languages.AMHARIC:
        return 'am';
      case Languages.ARABIC:
        return 'ar';
      case Languages.BENGALI:
        return 'bn';
      case Languages.CHINESE:
        return 'zh';
      case Languages.GREEK:
        return 'el';
      case Languages.GUJARATI:
        return 'gu';
      case Languages.HINDI:
        return 'hi';
      case Languages.KANNADA:
        return 'kn';
      case Languages.MALAYALAM:
        return 'ml';
      case Languages.MARATHI:
        return 'mr';
      case Languages.NEPALI:
        return 'ne';
      case Languages.ORIYA:
        return 'or';
      case Languages.PERSIAN:
        return 'fa';
      case Languages.PUNJABI:
        return 'pa';
      case Languages.RUSSIAN:
        return 'ru';
      case Languages.SANSKRIT:
        return 'sa';
      case Languages.SINHALESE:
        return 'si';
      case Languages.SERBIAN:
        return 'sr';
      case Languages.TAMIL:
        return 'ta';
      case Languages.TELUGU:
        return 'te';
      case Languages.TIGRINYA:
        return 'ti';
      case Languages.URDU:
        return 'ur';
      default:
        return 'en';
    }
  }
}

/// Supported languages
enum Languages {
  ENGLISH,
  AMHARIC,
  ARABIC,
  BENGALI,
  CHINESE,
  GREEK,
  GUJARATI,
  HINDI,
  KANNADA,
  MALAYALAM,
  MARATHI,
  NEPALI,
  ORIYA,
  PERSIAN,
  PUNJABI,
  RUSSIAN,
  SANSKRIT,
  SINHALESE,
  SERBIAN,
  TAMIL,
  TELUGU,
  TIGRINYA,
  URDU
}
