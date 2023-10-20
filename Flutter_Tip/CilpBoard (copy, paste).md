## Clipboard (copy, paste)

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // _control = 그 텍스트 필드에 있는 값
  final TextEditingController _control = TextEditingController();
  var _data = 'String Here';

  // _control.text에 있는 값을 클립보드에 복사한다.
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _control.text));
  }

  // 클립보드에 있는 값을 붙여넣기 한다.
  void pasteFromClipboard() async {
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);

    setState(() {
      _data = cdata?.text ?? 'got null...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(children: [
            // _textField
            TextField(
              controller: _control,
            ),
            // 이 버튼을 누르면 위 함수 작동 = 클립보드에 복사
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: copyToClipboard,
            ),
            Text(_data),
            // 이 버튼을 누르면 위 함수 작동 = 위 Text(_data)에 붙여넣기
            IconButton(
              icon: const Icon(Icons.paste),
              onPressed: pasteFromClipboard,
            )
          ]),
        ),
      ),
    );
  }
}
```