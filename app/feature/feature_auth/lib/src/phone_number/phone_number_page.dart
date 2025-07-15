import 'dart:async';

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:app_bloc/app_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' as tda;
import 'package:navigation/navigation.dart';

@RoutePage()
class PhoneNumberPage extends StatefulWidget implements AutoRouteWrapper {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<PhoneNumberCubit>(
      create: (_) => AppBlocHelper.getPhoneNumberCubit(),
      child: this,
    );
  }
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  Country selectedCountry = Country.parse('UZ');
  late final TextEditingController phoneController;
  late final ValueNotifier loadingListener;
  final Logger logger = Logger();
  late final tda.TdLibListenerService _tdLibListenerService;
  late final StreamSubscription<tda.AuthorizationState> authState;
  late final ValueNotifier<bool> visible = ValueNotifier(false);

  @override
  void initState() {
    loadingListener = ValueNotifier<bool>(false);
    phoneController = TextEditingController();
    _tdLibListenerService = tda.TdServiceHelper.geTdService();
    authState = _tdLibListenerService.authStream.listen((event){
      if(event.getConstructor() == tda.AuthorizationStateWaitCode.constructor){
        NavigationUtils.getAuthNavigation().navigateSetCode();
      }
    });

    super.initState();
  }

  String get fullPhoneNumber => '+${selectedCountry.phoneCode}${phoneController.text}';

  @override
  void dispose() {
    phoneController.dispose();
    loadingListener.dispose();
    authState.cancel();
    super.dispose();
  }

  Future<void> setPhoneNumber() async{
    loadingListener.value = true;
    await AppBlocHelper.getPhoneNumberCubit().set(fullPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
        valueListenable: visible,
        child: ValueListenableBuilder(
            valueListenable: loadingListener,
            builder: (context,value,child) {
              return FloatingActionButton(
                onPressed: value == true ? null : setPhoneNumber,
                child: value == true ? const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircularProgressIndicator.adaptive(),
                ) : const Icon(Icons.arrow_forward),
              );
            }
        ),
        builder: (context,value,child) {
          return value == true ? child! : const SizedBox.shrink();
        }
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: BlocListener<PhoneNumberCubit,tda.TdObject>(
        listener: (context,state){
          logger.i(state.getConstructor());
          if(state is tda.Ok){
            NavigationUtils.getAuthNavigation().navigateSetCode();
          }else if(state is tda.TdError){
            loadingListener.value = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your Phone',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Text(
                'Please select you country code and enter your phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text('${selectedCountry.flagEmoji}  ${selectedCountry.name}'),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      '+${selectedCountry.phoneCode}',
                      style: GoogleFonts.spaceMono(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: loadingListener,
                        builder: (context,value,widget) {
                          return TextField(
                            readOnly: value,
                            controller: phoneController,
                            onChanged: (number){
                              if(number.isNotEmpty){
                                visible.value = true;
                              }else {
                                visible.value = false;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.spaceMono(fontSize: 18),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // LengthLimitingTextInputFormatter(9),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
