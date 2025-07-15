part of 'verification_code_cubit.dart';

abstract class VerificationEvent{}

class Ready extends VerificationEvent{}



class Error extends VerificationEvent{
  Error({String? error});
}