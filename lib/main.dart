import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Ask Me Anything'),
            backgroundColor: Colors.blueGrey.shade900,
          ),
          body: MagicBallPage(),
        ),
      ),
    );

class MagicBallPage extends StatefulWidget {
  @override
  _MagicBallPageState createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  int _ballNumber;
  ShakeDetector _detector;
  Color _containerColor;

  /// Method that generate a random color
  void randomContainerBackgroundColor() {
    int shade = (Random().nextInt(9) + 1) * 100;
    print('shade = $shade');

    switch (_ballNumber) {
      case 1:
        _containerColor = Colors.blue[shade];
        break;
      case 2:
        _containerColor = Colors.red[shade];
        break;
      case 3:
        _containerColor = Colors.yellow[shade];
        break;
      case 4:
        _containerColor = Colors.green[shade];
        break;
      case 5:
        _containerColor = Colors.orange[shade];
        break;
    }
  }

  /// Method that generate a random face
  void randomBallFace() {
    setState(() {
      _ballNumber = Random().nextInt(4) + 1;
    });
  }

  /// Wrapper method
  void roll() {
    randomBallFace();
    randomContainerBackgroundColor();
  }

  @override
  void initState() {
    super.initState();
    _ballNumber = 1;
    _containerColor = Colors.blue;
    _detector = ShakeDetector.autoStart(onPhoneShake: () {
      roll();
      print('I got shaked!');
    });
    ShakeDetector.waitForStart();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _containerColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  roll();
                  print('I got clicked!');
                },
                child: Image.asset('images/ball$_ballNumber.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _detector.stopListening();
  }
}
