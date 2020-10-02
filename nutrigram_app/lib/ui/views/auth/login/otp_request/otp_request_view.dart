import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/auth/login/otp_request/otp_request_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/login/reset_password/reset_password_view.dart';
import 'package:stacked/stacked.dart';

class OtpRequestView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpRequestViewModel>.reactive(
      viewModelBuilder: () => locator<OtpRequestViewModel>(),
      builder: (
        BuildContext context,
        OtpRequestViewModel model,
        Widget child,
      ) {
        return Padding(
          padding: sXPagePadding.add(EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom)),
          child: Column(
            children: <Widget>[
              Text(
                forgotPassword,
                style: Theme.of(context).textTheme.button,
              ),
              mHeightSpan,
              DTextField(
                controller: _controller,
                textInputType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.phone_android,
                ),
                hintText: phoneNumber,
                enabled: !model.isBusy,
              ),
              mHeightSpan,
              DRaisedButton(
                title: requestNewPassword,
                onPressed: () async {
                  final bool resp =
                      await model.getForgetPasswordOTP(_controller.text);
                  if (resp) {
                    showCustomBottomSheet(
                      context,
                      child: ResetPasswordView(_controller.text),
                    );
                  }
                },
                loading: model.isBusy,
              ),
            ],
          ),
        );
      },
    );
  }
}
