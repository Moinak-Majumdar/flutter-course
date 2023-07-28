import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onNavItemAction});
  final void Function(String identifier) onNavItemAction;

  @override
  Widget build(context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 18),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
          NavItem(
            icon: Icons.account_circle,
            title: 'Profile',
            action: () {
              onNavItemAction('profile');
            },
          ),
          NavItem(
            icon: Icons.settings,
            title: 'Filter',
            action: () {
              onNavItemAction('filter');
            },
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.action});
  final String title;
  final IconData icon;
  final void Function() action;

  @override
  Widget build(context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onBackground,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
      onTap: action,
    );
  }
}
