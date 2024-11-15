part of 'strippyment_cubit.dart';

@immutable
sealed class StrippymentState {}

final class StrippymentInitial extends StrippymentState {}


final class PaymentLoading extends StrippymentState {}

final class PaymentSuccess extends StrippymentState {}

final class PaymentFailure extends StrippymentState {
  final String errMessage;
  PaymentFailure(this.errMessage);
}