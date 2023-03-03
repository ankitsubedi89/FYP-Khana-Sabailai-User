import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:khana_sabailai_user/utils/utils.dart';
import 'package:khana_sabailai_user/widgets/custom_text_field.dart';

class KhaltiPayment extends StatefulWidget {
  const KhaltiPayment({Key? key}) : super(key: key);

  @override
  State<KhaltiPayment> createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Payment')),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 1.0),
              colors: [Color(0xff5aa3d6), Color(0x00dcdcdc)],
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomFormField(
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              CustomFormField(
                label: 'Pin Code',
                isObscure: true,
                controller: pinCodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (phoneController.text.isEmpty) {
                    customGetSnackbar(
                        'Error', 'Phone number is required', 'error');
                    return;
                  }
                  if (pinCodeController.text.isEmpty) {
                    customGetSnackbar('Error', 'Pin code is required', 'error');
                    return;
                  }
                  final initiationModel = await Khalti.service.initiatePayment(
                    request: PaymentInitiationRequestModel(
                      amount: 1000,
                      mobile: phoneController.text,
                      productIdentity: 'pID',
                      productName: 'Product Name',
                      transactionPin: pinCodeController.text,
                      productUrl: '',
                      additionalData: {},
                    ),
                  );

                  final otp = await showDialog(
                      context: (context),
                      barrierDismissible: false,
                      builder: (context) {
                        String? opt;
                        return AlertDialog(
                          title: const Text('Enter OTP'),
                          content: TextField(
                            onChanged: (v) => opt = v,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('OTP'),
                            ),
                          ),
                          actions: [
                            SimpleDialogOption(
                                child: const Text('Submit'),
                                onPressed: () {
                                  Navigator.pop(context, opt);
                                })
                          ],
                        );
                      });

                  if (otp != null) {
                    try {
                      final model = await Khalti.service.confirmPayment(
                        request: PaymentConfirmationRequestModel(
                          confirmationCode: otp,
                          token: initiationModel.token,
                          transactionPin: pinCodeController.text,
                        ),
                      );

                      Navigator.pop(context, model.token);
                    } catch (e) {
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                child: const Text('Make Payment'),
              ),
            ],
          ),
        ));
  }
}
