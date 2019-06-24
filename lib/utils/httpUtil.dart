import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:cookie_jar/cookie_jar.dart';

class HttpUtil {
  HttpUtil(BuildContext context) {
    this.context = context;
  }
  BuildContext context;
  // global dio object
  static Dio dio;

  // default options
  static const String API_PREFIX = 'http://47.106.191.109:7001';
  static const int CONNECT_TIMEOUT = 20000;
  static const int RECEIVE_TIMEOUT = 10000;

  // http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  // request method
  Future<Map> request (
    String url, 
    {
      data,
      method,
      ContentType contentType,
    }
  ) async {
      data = data ?? {};
      method = method ?? 'GET';
      contentType = contentType ?? ContentType.json;

      // restful 请求处理   
      // /gysw/search/hist/:user_id        user_id=27
      // 最终生成 url 为     /gysw/search/hist/27
      data.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll(':$key', value.toString());
        }
      });

      // 打印请求相关信息：请求地址、请求方式、请求参数
      print('请求地址：【' + method + '  ' + url + '】');
      print('请求参数：' + data.toString());

      Dio dio = createInstance();

      // 添加拦截器
      // String csrfToken;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      dio.interceptors.add(CookieManager(PersistCookieJar(dir: '$tempPath/.cookies/')));
      // dio.interceptors.add(InterceptorsWrapper(
      //   onRequest: (Options options) {
      //     if(csrfToken == null) {
      //       print('no token，request token firstly...');
      //       dio.lock();
      //       return getToken().then((d) {
      //         options.headers['x-csrf-token'] = csrfToken = d['data']['csrfToken'];
      //         print("request token succeed, value: " + csrfToken);
      //         return options;
      //       }).whenComplete(() => dio.unlock());
      //     }else{
      //       options.headers['x-csrf-token'] = csrfToken;
      //       return options;
      //     }
      //   }
      //   onError: (DioError e) {
      //     // 授权失效拦截器
      //     if(e.response.statusCode == 501){
      //         Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
      //     }
      //   }
      // ));

      var result;

      // todo 错误处理优化
      try {
        Response response = await dio.request(url, data: data, options: new Options(method: method, contentType: contentType));

        result = response.data;

        // 打印响应相关信息
        print('响应数据：' + response.toString());
      } on DioError catch (e) {
        if(e.response == null){
          print('请求出错：' + e.request.toString() + '，详情信息：' + e.message);
        }else if(e.response.statusCode == 501){
          print('授权失效，回到首页');
          Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
        }else{
          print('请求出错：' + e.toString());
        }
      } 

      return result;
    }

    // 创建 dio 实例对象
    static Dio createInstance () {
      if (dio == null) {
        // 全局属性：请求前缀、连接超时时间、响应超时时间
        BaseOptions options = new BaseOptions(
            baseUrl: API_PREFIX,
            connectTimeout: CONNECT_TIMEOUT,
            receiveTimeout: RECEIVE_TIMEOUT,
        );

        dio = new Dio(options);
      }

      return dio;
    }

    static getToken() async {
      final tokenUrl = API_PREFIX + '/login/getToken';
      try {
        Response response = await Dio().get(tokenUrl);
        return response.data;
      } on DioError catch (e) {
        print('获取csrfToken失败' + e.toString());
      }
    }

    // 清空 dio 对象
    static clear () {
      dio = null;
    }
}