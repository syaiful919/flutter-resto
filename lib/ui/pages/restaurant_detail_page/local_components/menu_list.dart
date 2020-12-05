import 'package:flutter/material.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/ui/pages/restaurant_detail_page/local_components/section_title.dart';

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
        SectionTitle(title: title),
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
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
