import 'package:flutter/material.dart';
import 'package:olo/models/dish.dart';
import 'package:olo/screens/restaurants/order_dish.dart';


class DishScreen extends StatefulWidget {
  Dish dish;
  DishScreen({super.key, required this.dish});

  @override
  State<DishScreen> createState() => _Dish();
}

class _Dish extends State<DishScreen> with TickerProviderStateMixin {
  late String categoryName;

  @override
  void initState() {
    super.initState();
    categoryName = widget.dish.category.name;
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(categoryName, style: TextStyle(color: Colors.black, fontSize: 24)),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 1.0,
                    ),
                  ),
                  controller: tabController,
                  labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  indicatorColor: Colors.grey.shade900,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Text(
                          'Bergers',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Text(
                          'Pastas',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Text(
                          'Pizzas',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Text(
                          'Salads',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: AddOrderContent(),
                    ),
                  ),
                  Center(child: Text('Pastas Content')),
                  Center(child: Text('Pizzas Content')),
                  Center(child: Text('Burgers Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
