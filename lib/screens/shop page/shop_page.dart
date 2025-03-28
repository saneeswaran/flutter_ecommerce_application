import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/kids_shopping.dart';
import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/men_shopping.dart';
import 'package:cloth_ecommerce_application/screens/shop%20page/tab%20bar/women_shopping.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  //tab bat

  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: currentIndex,
      animationDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  List<String> tabBarTitle = ["Women", "Men", "Kids"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Categories",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          tabs: List.generate(
            tabBarTitle.length,
            (index) => Tab(child: Text(tabBarTitle[index])),
          ),
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: [WomenShopping(), MenShopping(), KidsShopping()],
      ),
    );
  }
}
