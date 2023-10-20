## Url_Launcher ( 하이퍼 링크 )

- IOS 설정법
    
    `ios/Runner/Info.plist` 파일을 열고
    
    이것처럼 붙여넣기
    
    ```swift
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      ...
      <key>LSApplicationQueriesSchemes</key>
      <array>
        <string>https</string>
        <string>http</string>
      </array>
    </dict>
    </plist>
    ```
    
- Android 설정법
    
    `android/app/src/main/AndroidManifest.xml` 파일을 열고
    
    이것처럼 붙여넣기
    
    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.example.url_launcher_example">
        <queries>
            <!-- If your app opens https URLs -->
            <intent>
                <action android:name="android.intent.action.VIEW" />
                <data android:scheme="https" />
            </intent>
            <!-- If your app makes calls -->
            <intent>
                <action android:name="android.intent.action.DIAL" />
                <data android:scheme="tel" />
            </intent>
            <!-- If your sends SMS messages -->
            <intent>
                <action android:name="android.intent.action.SENDTO" />
                <data android:scheme="smsto" />
            </intent>
            <!-- If your app sends emails -->
            <intent>
                <action android:name="android.intent.action.SEND" />
                <data android:mimeType="*/*" />
            </intent>
        </queries>
    
       <application>
            ...
        </application>
    </manifest>
    ```
    
- 사용법
    
    ```dart
    //사용
    import 'package:flutter/material.dart';
    //이친구를 사용하고
    import 'package:url_launcher/url_launcher.dart';
    
    class MyHomePage extends StatelessWidget {
      const MyHomePage({Key? key}) : super(key: key);
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('URL Launcher'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // web으로 가는거 사용법
                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://deku.posstree.com/en/',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('Web Link'),
                ),
                // mail으로 가는거 사용법
                ElevatedButton(
                  onPressed: () async {
                    // scheme: 이건 밑에 tel처럼 mail로 간다는 것을 뜻하는듯
                    // path: 이건 받는 사람의 메일
                    // query : 여기서 subject는 제목 body는 내용이 자동으로 입력되서 들어감
                    final url = Uri(
                      scheme: 'mailto',
                      path: 'dev-yakuza@gmail.com',
                      query: 'subject=Hello&body=Test',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('Mail to'),
                ),
                // call(전화)으로 가는거 사용법
                ElevatedButton(
                  onPressed: () async {
                    // url이라하긴 애매하지만 이건 이 번호로 누르면 바로 통화가 걸리게끔 만듬
                    final url = Uri.parse('tel:+1 555 010 999');
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('Tel'),
                ),
                // 메시지로 가는거 사용법
                ElevatedButton(
                  onPressed: () async {
                    // url이라하긴 애매하지만 메시지(그 사람 번호)
                    final url = Uri.parse('sms:5550101234');
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('SMS'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```