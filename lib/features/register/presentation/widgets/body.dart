import 'package:flutter/material.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

import 'package:secret_spice/widgets/primary_button/primary_button.dart';
import 'package:secret_spice/widgets/primary_text_input_field/primary_text_input_field.dart';


class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral50,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              "Get Started!",
              style: heading1.copyWith(color: neutral800),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Look like you are new to us! Create an\naccount for a complete experience.",
              style: subtitle1.copyWith(color: neutral500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              child: Column(
                children: <Widget>[
                  const PrimaryTextInputField(
                    hintText: "Username",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 25,),
                  const PrimaryTextInputField(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 25,),
                  const PrimaryTextInputField(
                    hintText: "Password",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            const Spacer(),
            PrimaryTextButton(
              labelText: "Next",
              onPressed: (){}
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
