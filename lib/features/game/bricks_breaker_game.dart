
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/game_page.dart';
import 'package:flutter/material.dart';


class BricksBreakerGame extends StatelessWidget {
  const BricksBreakerGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: Authenticator.builder(),
      title: gameTitle,
      theme: ThemeData.dark(),
      home: const GamePage(title: gameTitle),
    );
  }
}
