# 基本保護：保留所有 Flutter plugin 相關
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# 保留 Media3 (ExoPlayer) 類別避免混淆錯誤
-keep class androidx.media3.** { *; }
-dontwarn androidx.media3.**

# 保護 Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**