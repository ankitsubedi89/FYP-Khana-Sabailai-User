import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/bottomtab_controller.dart';
import 'package:khana_sabailai_user/controllers/main_controller.dart';
import 'package:khana_sabailai_user/widgets/content_head.dart';
import 'package:khana_sabailai_user/widgets/restaurant_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (controller.nearRestaurants.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const ContentHead(title: 'Restaurant near you'),
                      Text(controller.currentAddress),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: controller.nearRestaurants
                                .map((e) => RestaurantCard(
                                    restaurant: e, fromNear: true))
                                .toList()),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ContentHead(
                  title: 'All Restaurants',
                  trailing: InkWell(
                    onTap: () {
                      final bottomController = Get.find<BottomTabController>();
                      bottomController.currentIndex = 1;
                      bottomController.update();
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MasonryGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: controller.allRestaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantCard(
                        restaurant: controller.allRestaurants[index],
                        height: Random().nextInt(150) + 100,
                      );
                    })
                // Wrap(
                //   children: controller.allRestaurants
                //       .map((restaurant) => RestaurantCard(
                //             height: 112,
                //             marginRight: 5,
                //             marginBottom: 10,
                //             restaurant: restaurant,
                //           ))
                //       .toList(),
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
