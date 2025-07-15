import 'dart:async';

import 'package:app_bloc/app_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState>{
  VerificationCubit(
      this._setCodeUseCase
      ): super(VerificationState.init);

  final SetCodeUseCase _setCodeUseCase;
  StreamSubscription<AuthorizationState>? authorizationStream;

  Future<void> set(String code) async{
    try{
      await _setCodeUseCase.execute(code);
      listenUpdates();
    }catch(e){
      rethrow;
    }
  }

  void listenUpdates(){
    authorizationStream = _setCodeUseCase.stream.listen((event){
      switch(event.getConstructor()){
        case AuthorizationStateReady.constructor:
          emit(VerificationState.ready);
          break;
        case AuthorizationStateWaitPassword.constructor:
          emit(VerificationState.password);
          break;
        case AuthorizationStateWaitRegistration.constructor:
          emit(VerificationState.register);
          break;
        default:
      }
    });
  }

  @override
  Future<void> close() {
    authorizationStream?.cancel();
    return super.close();
  }

}