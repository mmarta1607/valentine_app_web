import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context, {
  required String message,
  String? imageAsset, // <- zamiast IconData
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.35), // WYSZARZENIE CAŁEGO EKRANU
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,        // STAŁA SZEROKOŚĆ
            height: 240,       // STAŁA WYSOKOŚĆ
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageAsset != null) ...[
                  Image.asset(
                    imageAsset,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // AUTO ZAMKNIĘCIE PO 3 SEKUNDACH
  Future.delayed(const Duration(seconds: 3), () {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  });
}