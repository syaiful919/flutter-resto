import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';

class MenuList extends StatelessWidget {
  final String title;
  final List<MenuItemModel> menus;

  const MenuList({
    Key key,
    this.title,
    this.menus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionTitle(title: "Minuman"),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          itemBuilder: (context, index) => MenuListItem(
            menu: menus[index],
          ),
        )
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.xxs),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final MenuItemModel menu;
  const MenuListItem({
    Key key,
    @required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "- ${menu.name}",
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
