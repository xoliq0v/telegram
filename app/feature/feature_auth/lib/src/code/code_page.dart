import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
import 'package:app_bloc/app_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

@RoutePage()
class CodePage extends StatefulWidget implements AutoRouteWrapper{
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<VerificationCubit>(
        create: (_)=> AppBlocHelper.getVerificationCubit(),
      child: this,
    );
  }
}

class _CodePageState extends State<CodePage> {
  late final TdLibListenerService _tdLibListenerService;
  late final StreamSubscription<AuthorizationState> _authSub;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  static const int codeLength = 5;

  @override
  void initState() {
    super.initState();
    _tdLibListenerService = TdServiceHelper.geTdService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _authSub = _tdLibListenerService.authStream.listen((state){
      final constructor = state.getConstructor();
      if(constructor == AuthorizationStateReady.constructor){
        if (mounted) {
          Future.microtask(() {
            if (mounted) {
              NavigationUtils.getMainNavigation().navigateMainPage();
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onCompleted(String code) {
    debugPrint("Entered code: $code");
    _focusNode.unfocus();
    AppBlocHelper.getVerificationCubit().set(code);
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Enter code',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 32),
                Text(
                  "We've sent an verification code to your official telegram app.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 270,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(codeLength, (index) {
                          final isFocused = index == code.length;
                          final isFilled = index < code.length;
                          final digit = isFilled ? code[index] : '';

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutBack,
                            width: 45,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isFocused
                                    ? Colors.blueAccent
                                    : Colors.grey.withOpacity(0.4),
                                width: isFocused ? 2.5 : 1.2,
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                              child: Text(
                                digit,
                                key: ValueKey(digit),
                                style: GoogleFonts.spaceMono(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      // Hidden TextField
                      Opacity(
                        opacity: 0,
                        child: TextField(
                          autofocus: true,
                          focusNode: _focusNode,
                          controller: _controller,
                          maxLength: codeLength,
                          keyboardType: TextInputType.number,
                          showCursor: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(codeLength),
                          ],
                          decoration: const InputDecoration(counterText: ''),
                          onChanged: (value) {
                            setState(() {});
                            if (value.length == codeLength) {
                              _onCompleted(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}