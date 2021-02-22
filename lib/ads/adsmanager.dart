import 'dart:io';

class AdsManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8691691433";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
static String get bannerId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/2247696110";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
}
