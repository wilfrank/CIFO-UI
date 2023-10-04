import 'package:cifo_flutter/features/fileManager/presentation/screen/file_manager_screen.dart';
import 'package:cifo_flutter/features/uploadFile/presentation/screen/upload_file_screen.dart';
import 'package:flutter/material.dart';

import 'package:cifo_flutter/features/home/presentation/screens/side_menu_widget.dart';
import 'package:cifo_flutter/shared/widgets/custom_elevated_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("CiFo")),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        drawer: const SideMenuWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const UploadFileScreen();
                        },
                      ),
                    );
                  },
                  text: "Subir Archivo"),
              const SizedBox(height: 50),
              CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FileManagerScreen();
                        },
                      ),
                    );
                  },
                  text: "Ver Archivos"),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
