import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/controllers/cart_controller.dart';
import 'package:khana_sabailai_user/models/menu.dart';
import 'package:khana_sabailai_user/widgets/cart_btn.dart';
import 'package:khana_sabailai_user/widgets/custom_button.dart';

// ignore: must_be_immutable
class SingleFoodScreen extends StatelessWidget {
  SingleFoodScreen({
    Key? key,
  }) : super(key: key);

  // Menu menu = Get.arguments;

  final Menu menu = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Hero(
              tag: 'food${menu.id}',
              child: Image(
                // image: NetworkImage(baseUrl + menu.image!),
                image: NetworkImage(baseurl + menu.image!),
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0x50000000),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        menu.food!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Rs. ${menu.price!}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Available Quantity ${menu.quantity!}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      menu.description!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CartController>(builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CartBtn(
                            onTap: () {
                              if (controller.foodQuantity > 1) {
                                controller.updateFoodQuantity(
                                    controller.foodQuantity - 1);
                              }
                            },
                            color: const Color(0xffff0000),
                            label: '-',
                            textColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            controller.foodQuantity.toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 67,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          CartBtn(
                            onTap: () {
                              if (controller.foodQuantity <
                                  int.parse(menu.quantity!)) {
                                controller.updateFoodQuantity(
                                    controller.foodQuantity + 1);
                              }
                            },
                            color: Colors.white,
                            label: '+',
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                          onPressed: () {
                            controller.addToCart(menu, controller.foodQuantity);
                          },
                          label: 'Add To Cart'),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        )
      ],
    ));
  }
}
