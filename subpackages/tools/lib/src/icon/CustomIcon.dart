import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SolidCircleIcon extends FaIcon {
  const SolidCircleIcon({super.key})
      : super(
          FontAwesomeIcons.solidCircle,
          color: Colors.amber,
          size: 14,
        );
}

class SolidCircleGreyIcon extends FaIcon {
  const SolidCircleGreyIcon({super.key})
      : super(
          FontAwesomeIcons.solidCircle,
          color: Colors.grey,
          size: 14,
        );
}

class CircleHalfStrokeIcon extends FaIcon {
  const CircleHalfStrokeIcon({super.key})
      : super(
          FontAwesomeIcons.circleHalfStroke,
          color: Colors.amber,
          size: 14,
        );
}
