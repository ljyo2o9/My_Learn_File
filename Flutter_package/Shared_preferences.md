```dart
import 'package:shared_preferences/shared_preferences.dart';

class _HomePageState extends State<HomePage> {
  String _main = '';

  SharedPreferences? _prefs; //내부 저장소에 저장되어있는 값을 불러오기 위한 변수

  final mainController = TextEditingController(); //TextField에 값을 받아오기 위한 변수1

  @override
  void initState() {
    super.initState();
    _loadId();
  }

  _loadId() async {
    _prefs = await SharedPreferences.getInstance(); // 캐시에 저장되어있는 값을 불러온다.(불러 올때까지 대기)

    setState(() {
      // SharedPreferences에 main으로 저장된 값을 읽어 필드에 저장. 없을 경우 0으로 대입
      _main = (_prefs!.getString('main') ?? '');
    });
  }

TextField(controller: idController) // 여기서 입력받은 String값을 idController에 전달
              
FloatingActionButton(
              child: const Icon(Icons.account_box),
              onPressed: () {
                _main = mainController.text; //_main은 TextField에서 받은

                _prefs!.setString('main', _main); // 내부 저장소에서 id를 키로 가지고 있는 값에 입력받은 _id를 넣어줌.

                showDialog(
                  // 버튼을 눌렀음을 확인시키기 위한 창 띄우기
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text(
                        '저장이 완료됐습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                );
              },
            ),

          Text('저장된 값: $_main'), // 어플을 재시작해도 데이터가 보존되는지 확인하기 위한 Text창
```