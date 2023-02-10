import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/cart_controller.dart';
import 'package:khana_sabailai_user/models/cart.dart';
import 'package:khana_sabailai_user/widgets/cart_row.dart';
import 'package:khana_sabailai_user/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: controller.cartList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Cart Empty',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text('Add items to cart to make an order'),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.cartList
                              .map(
                                (CartType e) => Column(
                                  children: [
                                    CartRow(
                                      cartItem: e,
                                    ),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Your total : ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Rs.${controller.getTotalPriceFromCartItems()}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            label: 'Order Now',
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.makeOrder();
                              }
                            }),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
        ),
      );
    });
  }
}
