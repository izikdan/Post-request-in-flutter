import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'user_model.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State createState() => _MyHomePageState();
}
Future<UserModel> createUser(String name, String jobTitle) async {
  const String apiUrl = "https://reqres.in/api/users";
    Uri uri = Uri.parse(apiUrl);
  final response =
      await http.post(uri, body: {"name": name, "job": jobTitle});
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return UserModel(name: "TTT", job: "OOO", id: "UUU", createdAt: DateTime.now());
  }
}
class _MyHomePageState extends State<MyHomePage> {
  late UserModel _user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
 @override
  void initState() {
    super.initState();
    _user = UserModel(name: "", job: "", id: "", createdAt: DateTime.now()); // הקצאת ערכים ריקים
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
            ),

            TextField(
              controller: jobController,
            ),

            const SizedBox(
              height: 32,
            ),
               Text(
                    "The user ${_user.name}, ${_user.job} is created successfully at time ${_user.createdAt.toIso8601String()}"),
       ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String name = nameController.text;
          final String jobTitle = jobController.text;
          final UserModel user = await createUser(name, jobTitle);
          setState(() {
            _user = user;
               createUser(nameController.text, jobController.text); 
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
