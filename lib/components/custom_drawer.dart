import 'package:flutter/material.dart';
import 'package:shop/components/custom_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                curve: Curves.easeInSine,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 60,
                ),
              ),
              CustomListTile(
                icon: Icons.shopify_outlined,
                text: "S H O P",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomListTile(
                icon: Icons.add_shopping_cart_outlined,
                text: "C A R T",
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, "/cart_page");
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: CustomListTile(
              icon: Icons.logout,
              text: "E X I T",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/intro_page");
              },
            ),
          ),
        ],
      ),
    );
  }
}
