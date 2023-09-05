import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

import 'package:secret_spice/widgets/primary_button/primary_button.dart';
import 'package:secret_spice/widgets/primary_text_icon_button.dart/priamary_text_icon_button.dart';


class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              "Let's get started",
              style: heading1.copyWith(color: neutral800),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sign up or login into to have a full digital\nexperience in our restaurant",
              style: subtitle1.copyWith(color: neutral500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            PrimaryTextButton(
              labelText: "Get Started",
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: neutral400,
                    ),
                  ),
                  Text(
                    "OR",
                    style: subtitle1.copyWith(color: neutral400),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: neutral400,
                    ),
                  ),
                ],
              ),
            ),
            const PrimaryTextIconButton(
              iconPath: "assets/icons/FacebookIcon.svg",
              labelText: "Continue with Facebook",
            ),
            const SizedBox(
              height: 10,
            ),
            const PrimaryTextIconButton(
              iconPath: "assets/icons/GoogleIcon.svg",
              labelText: "Continue with Google",
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
