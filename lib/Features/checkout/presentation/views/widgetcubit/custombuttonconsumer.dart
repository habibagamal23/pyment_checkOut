import 'package:checkout/Features/checkout/model/pymentinitiinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../logic/strippyment_cubit.dart';
import '../thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
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
        if( state is  PaymentLoading){
          return CircularProgressIndicator();
        }
        return CustomButton(

            onTap: () {
              PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(amount: 100, currency: "USD");
              context.read<StrippymentCubit>().makePayment(paymentIntentInputModel: paymentIntentInputModel);
            },
            text: 'Continue');
      },
    );
  }

}
