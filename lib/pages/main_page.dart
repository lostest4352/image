import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/routes/routes.dart';
import 'image_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<FileSystemEntity> files;

  @override
  void initState() {
    super.initState();
    files = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 45,
              title: Text("Image app"),
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
                                child: ImagePage(image: files[index] as File));
                          },
                        ),
                      );
                    },
                    child: Image.file(files[index] as File),
                  );
                },
              ),
            ),
            // SliverToBoxAdapter(
            //   child: BottomNavigationBar(
            //     items: bottomBarItems(),
            //   ),
            // ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                // For folder
                ListTile(
                  onTap: () async {
                    String? selectedDirectory =
                        await FilePicker.platform.getDirectoryPath();

                    if (selectedDirectory != null) {
                      setState(
                        () {
                          files.clear();

                          //
                          final directoryFiles =
                              Directory(selectedDirectory).listSync();
                          for (final file in directoryFiles) {
                            debugPrint(file.toString());
                            if (file.path.endsWith('.jpg') ||
                                file.path.endsWith('.jpeg') ||
                                file.path.endsWith('.png') ||
                                file.path.endsWith('.gif')) {
                              files.add(file);
                            }
                          }
                        },
                      );
                    }

                    if (!mounted) return;
                    Navigator.of(context).pop();
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

                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                  title: const Text('Open files'),
                ),
                ListTile(
                  title: const Text("Change settings"),
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteManager.settingsPage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<BottomNavigationBarItem> bottomBarItems() {
  //   return [
  //     const BottomNavigationBarItem(
  //       label: 'Home',
  //       icon: Icon(
  //         Icons.home,
  //         color: Colors.white,
  //       ),
  //       backgroundColor: Colors.amber,
  //     ),
  //     const BottomNavigationBarItem(
  //       label: 'Add',
  //       icon: Icon(Icons.add, color: Colors.white),
  //       backgroundColor: Colors.amber,
  //     ),
  //   ];
  // }
}
