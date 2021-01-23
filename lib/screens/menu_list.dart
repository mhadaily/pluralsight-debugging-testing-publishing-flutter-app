import 'package:flutter/material.dart';

import '../coffee_router.dart';
import '../models/coffee.dart';
import '../const.dart';
import 'menu_detail.dart';

/// Find the nth term in the Fibonacci sequence
int fib(int n) {
  if (n < 2) {
    //base case
    return n;
  }
  return fib(n - 2) + fib(n - 1); //recursive case
}

class MenuList extends StatelessWidget {
  const MenuList({
    @required this.coffees,
  }) : assert(coffees != null);

  final List<Coffee> coffees;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(height: 1, color: Colors.grey.shade400);
      },
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text(
              '${coffees[index].name} ${index == 15 ? fib(30) : ''} ',
              style: TextStyle(color: Colors.brown.shade800),
            ),
            leading: Icon(coffees[index].coffeeIcon, size: 40, color: brown),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          onTap: () {
            CoffeeRouter.instance.push(
              MenuDetails.route(coffee: coffees[index]),
            );
          },
        );
      },
    );
  }
}
