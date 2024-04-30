import 'package:fake_replit/api.dart';
import 'package:flutter/material.dart';
import 'package:code_editor/code_editor.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Replit',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EditorModel model;
  String terminalOutput = 'Output will be shown here';

  @override
  void initState() {
    super.initState();
    List<String> initialSnippet = [
      "# Print numbers from 1 to 5",
      "for i in range(1, 6):",
      " print(i)",
    ];
    List<FileEditor> files = [
      FileEditor(
        name: "code.py",
        language: "python",
        code: initialSnippet.join("\n"),
      ),
    ];
    model = EditorModel(
      files: files,
      styleOptions: EditorModelStyleOptions(
        showUndoRedoButtons: true,
        reverseEditAndUndoRedoButtons: true,
      )..defineEditButtonPosition(
          bottom: 15,
          left: 15,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final output =
              await apiRepository.getPythonOutput(model.getCodeWithIndex(0));
          setState(() {
            terminalOutput = output;
          });
        },
        backgroundColor: Colors.greenAccent[400],
        shape: const CircleBorder(),
        child: const Icon(Icons.play_arrow, color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: CodeEditor(
              model: model,
              formatters: const ["python"],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              color: Colors.black,
              child: Text(
                terminalOutput,
                style: GoogleFonts.ibmPlexMono(
                  color: Colors.greenAccent[400],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
