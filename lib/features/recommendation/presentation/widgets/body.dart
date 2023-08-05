import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';
import 'package:secret_spice/features/recommendation/presentation/widgets/bottom_sheet_action_sheet_modal.dart';

import 'package:secret_spice/widgets/appbar/appbar.dart';

import 'recipe_list.dart';


class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral100,
      appBar: Appbar(
        title: "Secret Spices",
        iconPath: "assets/icons/ScannerSolidIcon.svg",
        onPressed: () {
          Navigator.pushNamed(context, "/camera-preview");
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Column(
            children: [
              TabBar(
                indicator: BoxDecoration(
                  color: primary800,
                  borderRadius: BorderRadius.circular(16)
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent
                ),
                unselectedLabelColor: neutral500,
                labelStyle: heading5.copyWith(color: white),
                tabs: const <Widget>[
                  Tab(text: "All"),
                  Tab(text: "Veg"),
                  Tab(text: "Non-veg"),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                    child: const TabBarView(
                      children: <Widget>[
                        RecipeList(
                          itemCount: 10,
                          itemExtent: 140,
                        ),
                        RecipeList(
                          itemCount: 10,
                          itemExtent: 140,
                        ),
                        RecipeList(
                          itemCount: 10,
                          itemExtent: 140,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
