import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../services/api_para.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../database/app_preferences.dart';
import '../generated/i18n.dart';

class AppBaseClient {
  // Future<dynamic> getApiCall({
  //   String? url,
  //   Map<String, dynamic>? queryParams,
  //   Map<String, String>? headers,
  //   bool isWithoutToken = false,
  // }) async {
  //   if (connectivity) {
  //     try {
  //       log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams)}");
  //       http.Response response = await http
  //           .get(
  //             Uri.parse(generateQueryUrl(url: url, queryParams: queryParams)),
  //             headers: accessToken(isWithoutToken),
  //           )
  //           .timeout(const Duration(seconds: 60));
  //       log("API RESPONSE :: ${response.body}");
  //       log("API Status :: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         return jsonDecode(response.body);
  //       } else {
  //         log("Api failed with status code ${response.statusCode}");
  //         return null;
  //       }
  //     } on Exception catch (e) {
  //       log("Exception (getApiCall) :: $e");
  //       return null;
  //     }
  //   } else {
  //     CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
  //         color: CommonColors.mRed);
  //     return null;
  //   }
  // }
  //
  // Map<String, String>? accessToken(bool isWithoutToken) {
  //   log('isWithoutToken :: $isWithoutToken');
  //   if (isWithoutToken) {
  //     return null;
  //   } else {
  //     String accessToken = AppPreferences.instance.getAccessToken();
  //     log('access token :: $accessToken');
  //     return {"Authorization": "Bearer $accessToken"};
  //   }
  // }

  Future<dynamic> postApiWithTokenCall({
    String? url,
    Map<String, dynamic>? postParams,
    Map<String, dynamic>? queryParams,
  }) async {
    String accessToken = AppPreferences.instance.getAccessToken();
    log('access token :: $accessToken');
    if (connectivity) {
      try {
        log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams)}");
        log("PARAMETER :: ${jsonEncode(postParams)}");
        http.Response response = await http.post(
          Uri.parse(generateQueryUrl(url: url, queryParams: queryParams)),
          body: jsonEncode(postParams),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        );
        log("API RESPONSE :: ${response.body}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          log("Api failed with status code ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        log("Exception (postApiWithTokenCall) :: $e");
        return null;
      }
    } else {
      CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
          color: CommonColors.mRed);
      return null;
    }
  }

  Future<dynamic> getApiWithTokenCall({
    String? url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    String accessToken = AppPreferences.instance.getAccessToken();
    log('access token :: $accessToken');
    if (connectivity) {
      try {
        log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams)}");
        http.Response response = await http
            .get(
              Uri.parse(generateQueryUrl(url: url, queryParams: queryParams)),
              headers: accessToken.isNotEmpty
                  ? {"Authorization": "Bearer $accessToken"}
                  : {},
            )
            .timeout(const Duration(seconds: 90));
        log("API RESPONSE :: ${response.body}");
        log("API Status :: ${response.statusCode}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          log("Api failed with status code ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        log("Exception (getApiCall) :: $e");
        return null;
      }
    } else {
      CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
          color: CommonColors.mRed);
      return null;
    }
  }

  Future<dynamic> getApiCallWithOutToken({
    String? url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    if (connectivity) {
      try {
        log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams)}");
        http.Response response = await http
            .get(
              Uri.parse(
                generateQueryUrl(
                  url: url,
                  queryParams: queryParams,
                ),
              ),
            )
            .timeout(const Duration(seconds: 90));
        log("API RESPONSE :: ${response.body}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          log("Api failed with status code ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        log("Exception (getApiCallWithOutToken) :: $e");
        return null;
      }
    } else {
      CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
          color: CommonColors.mRed);
      return null;
    }
  }

  Future<dynamic> postApiWithoutTokenCall({
    String? url,
    Map<String, dynamic>? postParams,
  }) async {
    if (connectivity) {
      try {
        log("API URL :: $url");
        log("PARAMETER :: ${jsonEncode(postParams)}");
        http.Response response = await http.post(
          Uri.parse(url!),
          body: jsonEncode(postParams),
          headers: {"Content-Type": "application/json"},
        );
        log("API RESPONSE :: ${response.body}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          log("Api failed with status code ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        log("Exception (postApiCall) :: $e");
        return null;
      }
    } else {
      CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
          color: CommonColors.mRed);
      return null;
    }
  }

  // Future<dynamic> postApiCall({
  //   String? url,
  //   Map<String, dynamic>? postParams,
  //   Map<String, dynamic>? queryParams,
  //   bool isWithoutToken = false,
  // }) async {
  //   if (connectivity) {
  //     try {
  //       log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams)}");
  //       log("PARAMETER :: ${jsonEncode(postParams)}");
  //       http.Response response = await http.post(
  //         Uri.parse(generateQueryUrl(url: url, queryParams: queryParams)),
  //         body: jsonEncode(postParams),
  //         headers: accessToken(isWithoutToken),
  //         // {
  //         //   "Content-Type": "application/json",
  //         //   "Authorization": "Bearer $accessToken",
  //         // },
  //       );
  //       log("API RESPONSE :: ${response.body}");
  //       if (response.statusCode == 200) {
  //         return jsonDecode(response.body);
  //       } else {
  //         log("Api failed with status code ${response.statusCode}");
  //         return null;
  //       }
  //     } on Exception catch (e) {
  //       log("Exception (postApiWithTokenCall) :: $e");
  //       return null;
  //     }
  //   } else {
  //     CommonUtils.showSnackBar(
  //       S.of(mainNavKey.currentContext!)!.noInternet,
  //       color: CommonColors.mRed,
  //     );
  //     return null;
  //   }
  // }

  // Future<dynamic> postApiCall({
  //   String? url,
  //   Map<String, dynamic>? postParams,
  // }) async {
  //   if (connectivity) {
  //     try {
  //       log("API URL :: $url");
  //       log("PARAMETER :: ${jsonEncode(postParams)}");
  //       http.Response response = await http.post(
  //         Uri.parse(url!),
  //         body: jsonEncode(postParams),
  //         headers: {"Content-Type": "application/json"},
  //       );
  //       log("API RESPONSE :: ${response.body}");
  //       if (response.statusCode == 200) {
  //         return jsonDecode(response.body);
  //       } else {
  //         log("Api failed with status code ${response.statusCode}");
  //         return null;
  //       }
  //     } on Exception catch (e) {
  //       log("Exception (postApiCall) :: $e");
  //       return null;
  //     }
  //   } else {
  //     CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
  //         color: CommonColors.mRed);
  //     return null;
  //   }
  // }

  Future<dynamic> postVideoFormDataApiCall({
    required String url,
    required File file,
    required String fileKey,
    Map<String, String>? postParams,
    void Function(int, int)? onProgress,
  }) async {
    String accessToken = AppPreferences.instance.getAccessToken();
    log('access token :: $accessToken');
    log('API URL :: $url');
    if (connectivity) {
      try {
        final request = MultipartRequest(
          'POST',
          Uri.parse(url),
          onProgress: onProgress ??
              (int bytes, int total) {
                final progress = bytes / total;
                log('Progress :: $progress ($bytes/$total)');
              },
        );

        request.headers.addAll(accessToken.isNotEmpty
            ? {"Authorization": "Bearer $accessToken"}
            : {});
        if (postParams != null) {
          log("PARAMETER :: ${jsonEncode(postParams)}");
          postParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }
        request.files.add(
          await http.MultipartFile.fromPath(
            fileKey,
            file.path,
          ),
        );

        final streamedResponse = await request.send();
        http.Response response =
            await http.Response.fromStream(streamedResponse);
        log("URL :${streamedResponse.request?.url}");
        log("API Response :${response.body}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          return null;
        }
      } on Exception catch (e) {
        log('Exception :: $e');
        return null;
      }
    } else {
      CommonUtils.showSnackBar(
        S.of(mainNavKey.currentContext!)!.noInternet,
        color: CommonColors.mRed,
      );
      return null;
    }
  }

  Future<dynamic> postFormDataApiCall({
    required String url,
    List<File>? images,
    String? fileKey,
    Map<String, dynamic>? postParams,
  }) async {
    String accessToken = AppPreferences.instance.getAccessToken();
    log('access token :: $accessToken');
    log('API URL :: $url');
    log("PARAMETER :: ${jsonEncode(postParams)}");
    if (connectivity) {
      try {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(accessToken.isNotEmpty
            ? {"Authorization": "Bearer $accessToken"}
            : {});

        if (postParams != null) {
          log("PARAMETER :: ${jsonEncode(postParams)}");
          postParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }

        if (images != null && images.isNotEmpty) {
          for (var element in images) {
            request.files.add(
              http.MultipartFile(
                fileKey ?? ApiParams.image,
                File(element.path).readAsBytes().asStream(),
                File(element.path).lengthSync(),
                filename: File(element.path).path.split('/').last,
              ),
            );
          }
        }

        http.StreamedResponse streamedResponse = await request.send();
        http.Response response =
            await http.Response.fromStream(streamedResponse);
        log("URL :${streamedResponse.request?.url}");
        log("API Response :${response.body}");
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          return null;
        }
      } on Exception catch (e) {
        log('Exception :: $e');
        return null;
      }
    } else {
      CommonUtils.showSnackBar(
        S.of(mainNavKey.currentContext!)!.noInternet,
        color: CommonColors.mRed,
      );
      return null;
    }
  }

  // Future<dynamic> optionApiCall({
  //   String? url,
  //   Map<String, dynamic>? queryParams,
  //   Map<String, String>? headers,
  // }) async {
  //   String accessToken = AppPreferences.instance.getAccessToken();
  //   log('access token :: $accessToken');
  //
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     try {
  //       log("API URL :: ${generateQueryUrl(url: url!, queryParams: queryParams!)}");
  //       final client = http.Client();
  //       const method = 'OPTIONS';
  //       final request = http.Request(method,
  //           Uri.parse(generateQueryUrl(url: url, queryParams: queryParams)));
  //       request.headers.addAll({"WWW-Authorization": accessToken});
  //       final streamedResponse = await client.send(request);
  //       final response = await http.Response.fromStream(streamedResponse);
  //       log("API RESPONSE :: ${response.body}");
  //       if (response.statusCode == 200) {
  //         return jsonDecode(response.body);
  //       } else {
  //         log("Api failed with status code ${response.statusCode}");
  //         return null;
  //       }
  //     } on Exception catch (e) {
  //       log("Exception (optionApiCall) :: $e");
  //       return null;
  //     }
  //   } else {
  //     CommonUtils.showSnackBar(S.of(mainNavKey.currentContext!)!.noInternet,
  //         color: CommonColors.mRed);
  //     return null;
  //   }
  // }

  String generateQueryUrl({String? url, Map<String, dynamic>? queryParams}) {
    if (queryParams != null && queryParams.isNotEmpty) {
      queryParams.forEach((key, value) {
        if (queryParams.entries.first.key == key) {
          url = "$url?$key=$value";
        } else {
          url = "$url&$key=$value";
        }
      });
    }
    // log("API URL :: $url");
    return url!;
  }
}

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    super.method,
    super.url, {
    this.onProgress,
  });

  final void Function(int bytes, int totalBytes)? onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress!(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
