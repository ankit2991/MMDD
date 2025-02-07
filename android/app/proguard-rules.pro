# ProGuard rules to keep necessary classes and prevent warnings

# Keep all Play Core classes
-keep class com.google.android.play.core.** { *; }

# Keep Play Core and SplitCompatApplication classes
-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.**

# Keep SplitCompatApplication and related classes if you use Play Core features
-keep class com.google.android.play.core.splitcompat.** { *; }

# Flutter ProGuard rules
-keep class io.flutter.** { *; }
-keep class com.example.mddmerchant.** { *; }
-dontwarn io.flutter.embedding.**

# Don't warn on specific libraries
-dontwarn com.payu.cardscanner.PayU
-dontwarn com.payu.cardscanner.callbacks.PayUCardListener
-dontwarn com.payu.olamoney.OlaMoney
-dontwarn com.payu.olamoney.callbacks.OlaMoneyCallback
-dontwarn com.payu.olamoney.utils.PayUOlaMoneyParams
-dontwarn com.payu.olamoney.utils.PayUOlaMoneyPaymentParams
-dontwarn com.payu.ppiscanner.PayUQRScanner
-dontwarn com.payu.ppiscanner.PayUScannerConfig
-dontwarn com.payu.ppiscanner.interfaces.PayUScannerListener
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.slf4j.impl.StaticLoggerBinder
