`image`매개변수. 기본적으로 런처 아이콘이 사용됩니다.

- 아이콘 배경이 없는 앱 아이콘: 1152×1152픽셀이어야 하며 직경 768픽셀의 원 안에 맞아야 합니다.
- 배경이 있는 앱 아이콘: 960×960픽셀이어야 하며 직경 640픽셀의 원 안에 맞아야 합니다.

`dart run flutter_native_splash:create`

`dart run flutter_native_splash:remove`

- Main.dart
    
    ```dart
    import 'package:flutter_native_splash/flutter_native_splash.dart';
    
    void main() async {//main.dart
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      runApp(const MyApp());
    }
    
    @override
      Widget build(BuildContext context) {
        FlutterNativeSplash.remove(); //지워줘야 다음 화면이 보임
    
        return ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(
                child: HomePage(),
              ),
            );
          },
        );
      }
    ```
    
- pubspec.yaml
    
    ```yaml
    flutter_native_splash:
      color: "#008dff"
      background_image: assets/background.png
      image: assets/image.png
      branding: assets/branding.png
      branding_mode: bottom
    
      # 다크모드 설정
      color_dark: "#042a49"
      background_image_dark: "assets/dark-background.png"
      image_dark: assets/splash-invert.png
      branding_dark: assets/dart_dark.png
      
      # Android 12 이상 버전에서 적용
      android_12:
    	  icon_background_color: "#111111"
    	  image_dark: assets/image.png
    	  color_dark: "#042a49"
    	  icon_background_color_dark: "#eeeeee"
    ```