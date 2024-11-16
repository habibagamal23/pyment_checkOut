import 'package:checkout/Features/checkout/model/pymentinitiinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../logic/strippyment_cubit.dart';
import '../../../model/paypal/pyp.dart';
import '../../../service/paypal.dart';
import '../thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  final bool isPaypal;
  const CustomButtonBlocConsumer({
    super.key,
    required this.isPaypal,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StrippymentCubit, StrippymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is PaymentLoading) {
          return CircularProgressIndicator();
        }
        return CustomButton(
            onTap: () {
              if (isPaypal) {
                Paypal().exceutePaypalPayment(context, Paypal.transctionsData);
              } else {
                PaymentIntentInputModel paymentIntentInputModel =
                    PaymentIntentInputModel(
                        amount: 100,
                        currency: "USD",
                        customerId: "cus_RECyKiA9HpFEEQ");
                context.read<StrippymentCubit>().makePayment(
                    paymentIntentInputModel: paymentIntentInputModel);
              }
            },
            text: 'Continue');
      },
    );
  }
}

class OrderItemModel {}
