## Hive

- install
    
    ```yaml
    dependencies:
      hive: ^[version]
      hive_flutter: ^[version]
    
    dev_dependencies:
      hive_generator: ^[version]
      build_runner: ^[version]
    
    import 'package:hive/hive.dart'; # hive
    import 'package:hive_flutter/hive_flutter.dart'; # hive_flutter
    part 'todo_model.g.dart'; # build_runner
    Hive.registerAdapter(TodoModelAdapter()) #hive_generator
    ```
    
- 시작할때
    
    ```dart
    import 'package:hive_flutter/hive_flutter.dart';
    
    void main() async {
      await Hive.initFlutter(); // hive 시작
    
    	// 기존 자료형 외에 다른 모델 불러올때 불러오는 것
    	//TodoModelAdapter() 제작법은 밑에
      Hive.registerAdapter(TodoModelAdapter());
    
    	// 처음에 열어두면 나중엔 Hive.box만 해도 됨
      await Hive.openBox<TodoModel>('todoList');
    
      runApp(const MyApp());
    }
    ```
    
- model
    
    ```dart
    // 밑에 있는 HiveType과 HiveField를 선언하기 위해 필요함
    import 'package:hive/hive.dart';
    
    //얘를 미리 복붙해두고
    //flutter pub run build_runner build 이 명령어 사용하면
    //위에 시작할때 보인 Adapter 자동 생성
    part 'todo_model.g.dart'; 
    
    @HiveType(typeId: 1) // 이것들을 해둬야 Adapter가 생성됨
    class TodoModel {
      @HiveField(1, defaultValue: '')
      final String title;
    
      TodoModel({required this.title});
    
      factory TodoModel.fromMap(Map<String, dynamic> map) {
        return TodoModel(title: map['title']);
      }
    }
    ```
    
- Adapter
    
    ```dart
    // 이친구가 Adapter 본인
    // GENERATED CODE - DO NOT MODIFY BY HAND
    
    part of 'todo_model.dart';
    
    // **************************************************************************
    // TypeAdapterGenerator
    // **************************************************************************
    
    class TodoModelAdapter extends TypeAdapter<TodoModel> {
      @override
      final int typeId = 1;
    
      @override
      TodoModel read(BinaryReader reader) {
        final numOfFields = reader.readByte();
        final fields = <int, dynamic>{
          for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
        };
        return TodoModel(
          title: fields[1] == null ? '' : fields[1] as String,
        );
      }
    
      @override
      void write(BinaryWriter writer, TodoModel obj) {
        writer
          ..writeByte(1)
          ..writeByte(1)
          ..write(obj.title);
      }
    
      @override
      int get hashCode => typeId.hashCode;
    
      @override
      bool operator ==(Object other) =>
          identical(this, other) ||
          other is TodoModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
    }
    ```
    
- 선언과 사용
    
    ```dart
    // 여기 있는 경우는 직접 모델을 제작해 Adapter을 불러온 상황임
    // 복붙하지 말고 읽고 사용
    
    import 'package:todolist/model/todo_model.dart';
    import 'package:hive_flutter/hive_flutter.dart';
    
    class TodoDataSource {
      Box<TodoModel>? box; // 데이터를 담아둘 box선언
    
      TodoDataSource() {
        init(); //시작시 init 부르기
      }
    
      Future<void> init() async {// 얘가 init
    		// main.dart에서 openbox를 해주어서 box로 선언만
    		// Hive에 있는 'todoList'라는 key를 가진 애를 box라는 변수에 넣겠다는 의미도 있음
        box = Hive.box<TodoModel>('todoList'); 
      }
    
      Future<List<TodoModel>> get() async { // get
    
    		// await을 init에 안달았기 때문에 혹시모를 데이터가 안들어올 상황을 배제
        if (box == null) await init();
    
    		//데이터를 한개만 가져오는 경우
        response = box!.get(0); // 0 : index
    		response = box!.get('key'); // key 값으로 데이터를 읽어옴
    
        response = box!.values.toList(); // 데이터 전부를 리스트로 읽어오는 경우
        return response;
      }
    
      Future put(value) async { // write
        if (box == null) await init();
    
        box.put('key', 'hello'); //알아서 value에 따라 자료형이 바뀜
    		box.put('name', 10);
    		box.put('fruits', ['List1', 'List2', 'List3']);
    
    		box.add('random_key_value'); // List에서 사용하는 add와 똑같음
      }
    
      Future del() async {
        if (box == null) await init();
    
    		//전체 삭제
        await box!.clear();
      }
    
    	Future modify() async {
    		if(box == null) await init();
    		
    		// 첫번재에 나온 id값은 key값
    		// 원래 값이 있던 자리에 새로 put을 한다는 의미
    		box!.put(id, TodoModel(title: text, id: id));
    }
    ```