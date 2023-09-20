```dart
import 'package:kpostal/kpostal.dart';

String address = '지역을 설정해 주세요';

Text(address),

MaterialPageRoute(builder: (context) => KpostalView(
                      callback: (Kpostal result) {
                        setState(() {address = result.address;},
                        );
                      },
                    ),
                  ),
```