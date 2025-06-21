import 'dart:io';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdService {
  static String get interstitialAdUnitId {
    if (Platform.isIOS) {
      return dotenv.env['mvp_interstitial_id']!; // 테스트용 iOS ID
    } else {
      return 'ca-app-pub-3940256099942544/1033173712'; // 테스트용 안드로이드 ID
    }
  }

  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialAdReady = false;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;

          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  static void showInterstitialAd(VoidCallback? onAdClosed) {
    if (_isInterstitialAdReady) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {},
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _isInterstitialAdReady = false;
          loadInterstitialAd(); // 다음 광고 미리 로드
          onAdClosed?.call();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _isInterstitialAdReady = false;
          loadInterstitialAd(); // 다시 로드
        },
      );

      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  static bool get isInterstitialAdReady => _isInterstitialAdReady;

  static void dispose() {
    _interstitialAd?.dispose();
  }
}
