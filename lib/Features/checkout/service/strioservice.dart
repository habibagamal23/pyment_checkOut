import 'package:checkout/Features/checkout/model/ephmralkey.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../model/pymentinitiinput.dart';
import '../model/pymentinititmodel.dart';

class StripeService {
  final Dio _dio;

  StripeService() : _dio = Dio();
  final String apiKey =
      "sk_test_51QLO18KCYYcZnriZy6tOCTMspmHTC38AV7zMSfFD73CdQACvjgwNmwIDkFi8SI7D8xDrSfAMmaJlRTwv9PqqIOTI00iZvgjjVX";
  Future<PaymentIntentModel?> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    try {
      final response = await _dio.post(
          'https://api.stripe.com/v1/payment_intents',
          data: paymentIntentInputModel.toJson(),
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'Authorization': 'Bearer $apiKey',
          }));
      return PaymentIntentModel.fromJson(response.data);
    } on DioError catch (e) {
      print("Failed to create PaymentIntent: ${e.response?.data}");
      return null;
    }
  }

  Future initPaymentSheet({required String clientSecret , required String ephmralKey , required String customerId  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'habiba',
        customerEphemeralKeySecret: ephmralKey,
        customerId: customerId,

      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel =  await createEphemeralKey(customerId: paymentIntentInputModel.customerId);

    await initPaymentSheet(
        clientSecret: paymentIntentModel!.clientSecret! ,
        customerId: paymentIntentInputModel.customerId,
        ephmralKey: ephemeralKeyModel.secret );
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await _dio.post('https://api.stripe.com/v1/ephemeral_keys',
        data: {'customer': customerId},
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Stripe-Version': '2024-10-28.acacia'
            }));

    var ephermeralKey = EphemeralKeyModel.fromJson(response.data);

    return ephermeralKey;
  }
}
