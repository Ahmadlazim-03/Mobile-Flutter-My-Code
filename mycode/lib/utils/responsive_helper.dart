// lib/utils/responsive_helper.dart
import 'package:flutter/material.dart';

enum ScreenSize { small, medium, large }

class ResponsiveHelper {
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return ScreenSize.small;
    } else if (width < 900) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }
  
  static double getHorizontalPadding(BuildContext context, ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.small:
        return 16.0;
      case ScreenSize.medium:
        return 24.0;
      case ScreenSize.large:
        return 32.0;
    }
  }
  
  static double getOfferBannerHeight(BuildContext context, ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.small:
        return 160.0;
      case ScreenSize.medium:
        return 180.0;
      case ScreenSize.large:
        return 200.0;
    }
  }
  
  static double getBookItemWidth(BuildContext context, ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.small:
        return 140.0;
      case ScreenSize.medium:
        return 160.0;
      case ScreenSize.large:
        return 180.0;
    }
  }
  
  static double getLanguageItemWidth(BuildContext context, ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.small:
        return 80.0;
      case ScreenSize.medium:
        return 100.0;
      case ScreenSize.large:
        return 120.0;
    }
  }
  
  static double getAuthorItemWidth(BuildContext context, ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.small:
        return 100.0;
      case ScreenSize.medium:
        return 120.0;
      case ScreenSize.large:
        return 140.0;
    }
  }
}