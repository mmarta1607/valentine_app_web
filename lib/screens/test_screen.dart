import 'package:flutter/material.dart';
import 'package:valentine_app/widgets/app_snackbar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class TestScreen extends StatefulWidget {
  final VoidCallback onSuccess;

  const TestScreen({
    super.key,
    required this.onSuccess,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController valentineController = TextEditingController();
  final FocusNode valentineFocusNode = FocusNode();

  String? valentineError;

  double loveValue = 0;

  bool showCaptcha = false;

  final Set<int> selectedImages = {};

  final Set<int> correctImages = {1, 4, 5, 6, 8}; 

  final Map<int, String> wrongMessages = {
    2: '🥐\nTo nie Delta. To rogal.',
    3: '🐭\nBlisko... Ale to jest mysza.',
    7: '🦆\nSerio? Przecież to kaczka.',
    9: '👹\nTo jest dog-demon.',
  };

  @override
  void initState() {
    super.initState();

    valentineFocusNode.addListener(() {
      if (!valentineFocusNode.hasFocus) {
        validateValentine();
      }
    });

    valentineController.addListener(() {
      setState(() {});
    });
  }

  void validateValentine() {
    setState(() {
      if (valentineController.text.trim() != 'Marta') {
        valentineError = 'Nie znam. Lepiej spróbuj jeszcze raz...';
      } else {
        valentineError = null;
      }
    });
  }

  String get loveMessage {
    if (loveValue < 1) return '';
    if (loveValue < 30) return 'serio?';
    if (loveValue < 70) return 'jeszcze troszkę...';
    if (loveValue < 100) return 'no weź...';
    return 'to jest poprawna odpowiedź! 💖';
  }

  bool get isCaptchaValid {
    return selectedImages.containsAll(correctImages) &&
          selectedImages.length == correctImages.length;
  }

  bool get isFormValid {
    return valentineController.text.trim() == 'Marta' &&
          loveValue == 100 &&
          isCaptchaValid;
  }

  void trySubmit() {
    validateValentine();

    if (!isFormValid) return;

    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test walentynkowy 💘',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40),

                  /// WALENTYNKA
                  AppTextField(
                    controller: valentineController,
                    label: 'Imię Twojej walentynki',
                    errorText: valentineError,
                    focusNode: valentineFocusNode,
                  ),

                  const SizedBox(height: 40),

                  /// SLIDER
                  Text(
                    'Jak bardzo mnie lubisz?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),

                      thumbColor: Theme.of(context).primaryColor,
                      overlayColor:
                          Theme.of(context).primaryColor.withOpacity(0.15),

                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 10,
                      ),

                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 18,
                      ),

                      valueIndicatorShape:
                          const PaddleSliderValueIndicatorShape(),

                      valueIndicatorColor: Theme.of(context).primaryColor,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Slider(
                      value: loveValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: loveValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          loveValue = value;
                        });
                      },
                    ),
                  ),

                  Center(
                    child: Text(
                      loveMessage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                    const SizedBox(height: 40),

                    /// CHECKBOX
                    Row(
                      children: [
                        Checkbox(
                          value: showCaptcha,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              showCaptcha = value ?? false;
                              if (!showCaptcha) {
                                selectedImages.clear();
                              }
                            });
                          },
                        ),
                        const Text('Nie jestem robotem'),
                      ],
                    ),

                    if (showCaptcha) ...[
                      const SizedBox(height: 16),

                      Text(
                        'Zaznacz wszystkie obrazki, na których znajduje się Delta Dog 🐶',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 16),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final imageIndex = index + 1;
                          final isSelected = selectedImages.contains(imageIndex);

                          return GestureDetector(
                            onTap: () {
                              if (!correctImages.contains(imageIndex)) {
                                showAppSnackBar(
                                  context,
                                  message: wrongMessages[imageIndex] ?? 'To nie ten 😅',
                                );
                                return;
                              }

                              setState(() {
                                if (isSelected) {
                                  selectedImages.remove(imageIndex);
                                } else {
                                  selectedImages.add(imageIndex);
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/captcha$imageIndex.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              text: 'Wyślij formularz',
              onPressed: trySubmit,
              enabled: isFormValid,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    valentineController.dispose();
    valentineFocusNode.dispose();
    super.dispose();
  }
}