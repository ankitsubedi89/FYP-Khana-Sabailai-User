import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/main_controller.dart';
import 'package:khana_sabailai_user/widgets/custom_search_field.dart';
import 'package:khana_sabailai_user/widgets/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                color: Colors.black,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text('All Restaurants'),
          ),
          body: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchField(onChanged: (val) {
                    controller.search(val);
                  }),
                  const SizedBox(height: 20),
                  Expanded(
                    child: MasonryGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        itemCount: controller.filteredRestaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurant: controller.filteredRestaurants[index],
                            height: Random().nextInt(100) + 100,
                          );
                        }),
                  )
                ],
              )));
    });
  }
}
