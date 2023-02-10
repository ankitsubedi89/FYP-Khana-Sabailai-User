import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/menu_controller.dart';
import 'package:khana_sabailai_user/models/category.dart';
import 'package:khana_sabailai_user/models/restaurant.dart';
import 'package:khana_sabailai_user/widgets/food_card.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  // final Restaurant restaurant = Get.arguments.restaurant;
  // final Category category = Get.arguments.category;
  final Category category = Get.arguments[0];
  final Restaurant restaurant = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name!),
      ),
      body: GetBuilder<MenuController>(builder: (controller) {
        return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: controller
                    .getFilteredMenu(category.id, restaurant.id)
                    .isNotEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: controller
                        .getFilteredMenu(category.id, restaurant.id)
                        .map((e) => FoodCard(
                              menu: e,
                            ))
                        .toList(),
                  )
                : const Center(
                    child: Text('No menu found'),
                  ));
      }),
    );
  }
}
