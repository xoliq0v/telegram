part of 'phone_number_cubit.dart';

abstract class PhoneNumberEvent{}

class Success extends PhoneNumberEvent{}

class Error extends PhoneNumberEvent{
  Error({String? error,int? code});
}