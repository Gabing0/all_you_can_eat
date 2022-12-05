import 'package:all_you_can_eat/mobile/landing_page_mobile.dart';
import 'package:all_you_can_eat/mobile/register_login_mobile.dart';
import 'package:all_you_can_eat/mobile/restaurant_menu_section_mobile.dart';
import 'package:all_you_can_eat/mobile/restaurant_section_mobile.dart';
import 'package:all_you_can_eat/mobile/restaurant_summary_section_mobile.dart';
import 'package:all_you_can_eat/web/landing_page_web.dart';
import 'package:all_you_can_eat/web/register_login_web.dart';
import 'package:all_you_can_eat/web/restaurant_menu_section_web.dart';
import 'package:all_you_can_eat/web/restaurant_section_web.dart';
import 'package:all_you_can_eat/web/restaurant_summary_section_web.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'view_model.dart';

class ResponsiveHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    viewModelProvider.isLoggedIn();

    if (viewModelProvider.isSignedIn) {
      if (viewModelProvider.isRstrFound) {
        switch (viewModelProvider.tab) {
          case '/menu':
            {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return RestaurantMenuSectionWeb(
                      context: context, viewModelProvider: viewModelProvider);
                } else {
                  return RestaurantMenuSectionMobile(
                      context: context, viewModelProvider: viewModelProvider);
                }
              });
            }
          case '/summary':
            {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return RestaurantSummarySectionWeb(
                      context: context, viewModelProvider: viewModelProvider);
                } else {
                  return RestaurantSummarySectionMobile(
                      context: context, viewModelProvider: viewModelProvider);
                }
              });
            }
          default:
            {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return RestaurantSectionWeb(
                      context: context, viewModelProvider: viewModelProvider);
                } else {
                  return RestaurantSectionMobile(
                      context: context, viewModelProvider: viewModelProvider);
                }
              });
            }
        }
      } else {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return LandingPageWeb(
                context: context, viewModelProvider: viewModelProvider);
          } else
            return LandingPageMobile(
                context: context, viewModelProvider: viewModelProvider);
        });
      }
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return RegisterLoginWeb();
        } else
          return RegisterLoginMobile();
      });
    }
  }
}
