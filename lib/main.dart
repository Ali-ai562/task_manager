import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controller/all_provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/views/home/home_page.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(PriorityAdapter()); 
  await Hive.openBox<TaskModel>('tasksBox');
  runApp(ChangeNotifierProvider(create: (_) => AllProvider(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 109, 109, 109),
        ),
        textTheme: GoogleFonts.anticDidoneTextTheme(
          Theme.of(context).textTheme,
        ).merge(GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),),
      home: const HomePage(),
    );
  }
}
