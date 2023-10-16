import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:bluck_buster/features/game/game_page.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              menuBckgrnd,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Select Level',
                style: TextStyle(
                    fontSize: 25, color: Colors.black, fontFamily: "Knewave"),
              ),
              const SizedBox(
                height: 10,
              ),
              ...List.generate(4, (index) => _LevelButton(level: index + 1))
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelButton extends StatelessWidget {
  const _LevelButton({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.black),
              shape:
                  const StadiumBorder(side: BorderSide(color: Colors.orange))),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(initialLevel: level),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LEVEL: $level',
                style: const TextStyle(),
              ),
            ],
          )),
    );
  }
}
