import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/pymentinitiinput.dart';
import '../service/paypal.dart';
import '../service/strioservice.dart';

part 'strippyment_state.dart';

class StrippymentCubit extends Cubit<StrippymentState> {
  StrippymentCubit(this.checkoutRepo) : super(StrippymentInitial());

  final StripeService checkoutRepo;
  final Paypal paypalService = Paypal();
  String selectedMethod = '';

  void selectPaymentMethod(String method) {
    selectedMethod = method;
    emit(PaymentMethodSelected(method));
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());

    try {
      await checkoutRepo.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  @override
  void onChange(Change<StrippymentState> change) {
    print(change.toString());
    super.onChange(change);
  }
}
