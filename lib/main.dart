import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/image_page.dart';

void main() {
  // Dark navigation bar. Code may give issues.
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  final int? index;

  const MainPage({this.index, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List files = [File('')];

  // RangeValues rangeValues = RangeValues(0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          ),
          SliverFillRemaining(
            child: PageView.builder(
              // scrollDirection: Axis.vertical,
              itemCount: files.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InteractiveViewer(
                              child: ImagePage(image: files[index]));
                        },
                      ),
                    );
                  },
                  child: Image.file(files[index]),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BottomNavigationBar(
              items: bottomBarItems(),
            ),
          ),
        ],
      ),

      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              // For folder
              ListTile(
                onTap: () async {
                  String? result = await FilePicker.platform.getDirectoryPath();

                  if (result != null) {
                    setState(
                      () {
                        files.clear();
                        Directory(result).listSync().forEach(
                          (f) {
                            if (f is File && f.path.endsWith('.jpg') ||
                                f.path.endsWith('.jpeg') ||
                                f.path.endsWith('.png') ||
                                f.path.endsWith('.gif')) {
                              files.add(f);
                            }
                          },
                        );
                      },
                    );
                  }
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text('Open folder'),
              ),
              // For individual or multiple files
              ListTile(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: true);

                  if (result != null) {
                    setState(
                      () {
                        files.clear();
                        files = result.paths
                            .map((path) => File(path.toString()))
                            .toList();
                      },
                    );
                  }
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text('Open files'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomBarItems() {
    return [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
      ),
      const BottomNavigationBarItem(
        label: 'Add',
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.amber,
      ),
    ];
  }
}
