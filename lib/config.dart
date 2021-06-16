import 'dart:developer';
import 'package:flutter/services.dart';

enum Flavor {
  DEV,
  PROD,
}

typedef MethodResponse<T> = void Function(T value);



class AppConfig {

  static final String KChannelName = 'flavor';
  static final String KMethodName = 'getFlavor';

  final String webViewUrl;
  Flavor appFlavor;

  AppConfig(this.appFlavor, this.webViewUrl);

  static AppConfig _instance;

  static AppConfig getInstance() => _instance;


  static configure(MethodResponse fn) async {
    try{
      final flavor = await MethodChannel(KMethodName)
      .invokeMethod<String>(KMethodName);
      log('Stared with flavor $flavor');

      _setupEnvironment(flavor);
      fn(true);
    } catch(e){
      log('Stared with flavor ${e.message}');

      fn(false);
    }
  }

  static _setupEnvironment(String flavorName) async{
     String webViewUrl;
     Flavor flavor;

     if(flavorName == 'dev'){
       webViewUrl = '';
       flavor = Flavor.DEV;
     }else {
       webViewUrl = '';
       flavor = Flavor.PROD;
     }

     _instance = AppConfig(flavor, webViewUrl);
  }

}
