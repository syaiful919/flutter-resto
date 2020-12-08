import 'package:flutter/material.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({
    Key key,
    @required this.searchAnimation,
    @required this.rotationAnimation,
    @required this.favAnimation,
    @required this.settingAnimation,
    @required this.animationController,
    this.searchAction,
    this.settingAction,
    this.favAction,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation rotationAnimation;
  final Animation searchAnimation;
  final Animation favAnimation;
  final Animation settingAnimation;

  final VoidCallback searchAction;
  final VoidCallback favAction;
  final VoidCallback settingAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        IgnorePointer(child: Container(height: 150, width: 150)),
        Transform.translate(
          offset: Offset.fromDirection(
              _getRadiansFromDegree(225), favAnimation.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(
              _getRadiansFromDegree(rotationAnimation.value),
            )..scale(favAnimation.value),
            alignment: Alignment.center,
            child: CircularButton(
              color: Colors.pinkAccent,
              iconData: Icons.favorite,
              onClick: favAction,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(
              _getRadiansFromDegree(270), searchAnimation.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(
              _getRadiansFromDegree(rotationAnimation.value),
            )..scale(searchAnimation.value),
            alignment: Alignment.center,
            child: CircularButton(
              color: Colors.blue,
              iconData: Icons.search,
              onClick: searchAction,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset.fromDirection(
              _getRadiansFromDegree(180), settingAnimation.value * 100),
          child: Transform(
            transform: Matrix4.rotationZ(
              _getRadiansFromDegree(rotationAnimation.value),
            )..scale(settingAnimation.value),
            alignment: Alignment.center,
            child: CircularButton(
              color: Colors.orangeAccent,
              iconData: Icons.settings,
              onClick: settingAction,
            ),
          ),
        ),
        Transform(
          transform:
              Matrix4.rotationZ(_getRadiansFromDegree(rotationAnimation.value)),
          alignment: Alignment.center,
          child: CircularButton(
            color: Colors.red,
            width: 60,
            height: 60,
            iconData: Icons.menu,
            onClick: () {
              if (animationController.isCompleted) {
                animationController.reverse();
              } else {
                animationController.forward();
              }
            },
          ),
        )
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final IconData iconData;
  final Function onClick;

  CircularButton({
    this.color,
    this.width = 50,
    this.height = 50,
    this.iconData,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
        icon: Icon(iconData, color: Colors.white),
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}

double _getRadiansFromDegree(double degree) {
  double unitRadian = 57.295779513;
  return degree / unitRadian;
}
