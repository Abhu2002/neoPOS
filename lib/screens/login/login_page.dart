import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopos/navigation/route_paths.dart';
import 'package:neopos/utils/utils.dart';
import '../../utils/action_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_text.dart';
import '../../utils/sharedpref/sharedpreference.dart';
import 'login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    context.read<LoginBloc>().onLoginSuccess = onSuccess;
    context.read<LoginBloc>().showMessage = createSnackBar;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (screenWidth>850)?const Expanded(
                    child:
                    Image(
                  image: AssetImage("assets/login_page_image.jpg"),
                  fit: BoxFit.cover,
                )):Container(),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(
                            "assets/login_background.svg",
                            fit: BoxFit.fill,
                            width: screenWidth,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .welcomeBack,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize:
                                                (screenWidth < 1000) ? 32 : 50,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        return SizedBox(
                                          width: (screenWidth>850)?MediaQuery.sizeOf(context).width / 4:MediaQuery.sizeOf(context).width-100,
                                          child: AuthCustomTextfield(
                                            obscureText: false,
                                            suffixIcon:
                                                state.userId.isNotEmptyValidator
                                                    ? const Icon(Icons.done)
                                                    : null,
                                            prefixIcon: Icons.person,
                                            hint: AppLocalizations.of(context)!
                                                .username,
                                            errorText: (!state.userId
                                                        .isNotEmptyValidator &&
                                                    state.verifyData)
                                                ? AppLocalizations.of(context)!
                                                    .username_error
                                                : null,
                                            onChange: (v) {
                                              context
                                                  .read<LoginBloc>()
                                                  .add(UserIdChanged(v));
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        return SizedBox(
                                          width:(screenWidth>850)?MediaQuery.sizeOf(context).width / 4:MediaQuery.sizeOf(context).width-100,
                                          child: AuthCustomTextfield(
                                            obscureText: true,
                                            suffixIcon:
                                                state.password.isValidPassword
                                                    ? const Icon(Icons.done)
                                                    : null,
                                            prefixIcon: Icons.lock,
                                            hint: AppLocalizations.of(context)!
                                                .password,
                                            errorText: !state.password
                                                        .isValidPassword &&
                                                    state.verifyData
                                                ? AppLocalizations.of(context)!
                                                    .password_error
                                                : null,
                                            onChange: (v) {
                                              context
                                                  .read<LoginBloc>()
                                                  .add(PasswordChanged(v));
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        return SizedBox(
                                          width:(screenWidth>850)?MediaQuery.sizeOf(context).width / 8:MediaQuery.sizeOf(context).width-200,
                                          child: ActionButton(
                                            text: AppLocalizations.of(context)!
                                                .login,
                                            state: state.state,
                                            onPress: () {
                                              context
                                                  .read<LoginBloc>()
                                                  .add(OnLogin());
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSuccess() {
    LocalPreference.setSignWith("set");
    Navigator.popAndPushNamed(context, RoutePaths.dashboard,arguments: LoginBloc.userRole);
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
