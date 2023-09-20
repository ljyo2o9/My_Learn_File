```dart
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile =
    await picker.pickImage(source: imageSource, imageQuality: 100);
    setState(() {
      image = XFile(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              onPressed: () async {
                await getImage(ImageSource.gallery);
                print(image!.path);
              },
              child: Text('button'),
            ),
          ),
          image == null
              ? Container()
              : Center(
            child: SizedBox(
              width: 500,
              height: 500,
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```