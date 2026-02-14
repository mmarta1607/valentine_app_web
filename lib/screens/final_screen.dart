import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  int noClicks = 0;
  double noTop = 420;
  double noLeft = 120;
  double noScale = 1;

  bool showResult = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  void _randomizePosition() {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;

    noTop = 150 + random.nextDouble() * (screenSize.height * 0.5);
    noLeft = 20 + random.nextDouble() * (screenSize.width * 0.6);
  }


  void _handleNoClick() {
    setState(() {
      noClicks++;
      noScale *= 0.7;
    });

    if (noClicks == 1) {
      // pierwsze kliknięcie — dopiero teraz losujemy
      _randomizePosition();
    } else if (noClicks < 5) {
      _randomizePosition();
    }
  }


  void _handleYesClick() {
    setState(() {
      showResult = true;
    });

    _confettiController.play();
  }

  Widget buildFinalButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!showResult) ...[
                  Text(
                    'Czy będziesz moją walentynką? 💘',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 60),

                  buildFinalButton(
                    text: 'TAK 💗',
                    onPressed: _handleYesClick,
                  ),

                  const SizedBox(height: 16),

                  if (noClicks == 0)
                    buildFinalButton(
                      text: 'Nie',
                      onPressed: _handleNoClick,
                    ),
                ] else ...[
                  Text(
                    'Marta + Michał = happy Valentine\'s Day! 💖',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ],
            ),
          ),

          // UCIEKAJĄCY PRZYCISK NIE (po pierwszym kliknięciu)
          if (!showResult && noClicks > 0 && noClicks < 3)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: noTop,
              left: noLeft,
              child: Transform.scale(
                scale: noScale,
                child: SizedBox(
                  width: 220,
                  child: buildFinalButton(
                    text: 'Nie',
                    onPressed: _handleNoClick,
                  ),
                ),
              ),
            ),

          // CONFETTI
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 30,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}