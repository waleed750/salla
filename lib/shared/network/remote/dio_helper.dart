import 'package:salla/shared/imports/exports.dart';

class DioHelper
{
  static late final  Dio dio ;
  static void init()
  {

    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/' ,
      headers: {
        'lang':'en' ,
        'Content-Type':'application/json'
      }
    ));
  }

  static Future<Response> getData({
  required String path ,
  Map<String , dynamic>? queryParameters,
    lang = 'en' ,
    String? authorization ,

}) async
  {
    dio.options.headers = {
      'lang' :lang ,
      'Authorization' : authorization ,
      'Content-Type':'application/json'
    };
      return await dio.get(path ,
      queryParameters: queryParameters ,
      );
  }

  static Future<Response> postData ({
  required String path ,
  Map<String , dynamic>? queryParameters ,
  lang = 'en' ,
  String? authorization ,
  dynamic data
})async
  {
    dio.options.headers = {
      'lang' :lang ,
      'Authorization' : authorization ,
      'Content-Type':'application/json'
    };
    return await dio.post(path ,
    data:  data,
    queryParameters: queryParameters
    );
  }
  static Future<Response> putData({
  required String path ,
  required String authorization ,
  Map<String , dynamic>? queryParameters ,
  String lang = 'en' ,
  dynamic data ,
})async
  {
    dio.options.headers = {
      'lang' : lang ,
      'Content-Type' : 'application/json' ,
      'Authorization' : authorization
    };
    return await dio.put(path ,
    queryParameters: queryParameters ,
    data: data
    );
  }
}