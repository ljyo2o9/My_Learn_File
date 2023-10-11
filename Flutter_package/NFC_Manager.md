## NFC_Manager

```dart
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // ValueNotifier는 값의 변경을 감지할 수 있는 클래스입니다.
  // 여기서 result라는 이름으로 ValueNotifier 객체를 생성하였으며,
  // 이 객체의 값이 변경될 때마다 관련 UI가 업데이트됩니다.
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            // 지금 nfc가 켜져 있는지 꺼져 있는지 확인하는 애
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Column(
                    //left: 10 right: 10,top: 20,bottom: 20,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            // ValueListenableBuilder는 valueListenable 객체가 업데이트될 때마다 builder를 호출하여 UI를 재구성합니다.
                            child: ValueListenableBuilder<dynamic>(
                              // result가 업데이트될 때마다 Text('${value ?? ''}')가 재구성되어 화면에 표시됩니다.
                              valueListenable: result,
                              builder: (context, value, _) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${value ?? ''}'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Tag Read'),
                        onPressed: _tagRead,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    // NfcManager의 인스턴스를 통해 NFC 세션을 시작합니다.
    // onDiscovered 파라미터로 전달된 콜백 함수는 NFC 태그가 발견될 때 호출됩니다.
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      // 발견된 NFC 태그의 데이터를 result 값으로 설정합니다.
      result.value = tag.data;

      // 데이터를 읽은 후에는 stopSession 메서드를 호출하여 NFC 세션을 종료합니다.
      NfcManager.instance.stopSession();
    });
  }
}
```