import 'dart:developer';

import 'package:app_bloc/app_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

part 'phone_number_event.dart';

class PhoneNumberCubit extends Cubit<AuthorizationState> {
  PhoneNumberCubit(this._sendPhoneNumber) : super(const AuthorizationStateWaitPhoneNumber());


  final SendPhoneNumberUseCase _sendPhoneNumber;

  Future<void> set(String phoneNumber) async{
    try{
      final result = await _sendPhoneNumber.execute(phoneNumber);
      if(result.isSuccess){
        // add(Success());
      }else if(result.isFailure){
        log(result.error);
        // add(Error(error: result.message,code: result.code));
      }else{
        // add(Error(error: 'Something went wrong! ${result.toString()}'));
      }
    }catch(e){
      // add(Error(error: e.toString()));
    }
  }

}