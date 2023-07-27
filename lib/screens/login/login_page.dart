import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neopos/utils/utils.dart';
import '../../utils/action_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_text.dart';
import '../dashboard/dashboard_page.dart';
import 'login_bloc.dart';

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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Expanded(
                      child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/login_background.svg",
                        fit: BoxFit.fill,
                        width: screenWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Welcome \nback",
                              style: TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontSize: (screenWidth < 1000) ? 32 : 50,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            )),
                      )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: (screenWidth < 1000) ? 300 : 600,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return AuthCustomTextfield(
                                obscureText: false,
                                suffixIcon: state.userId.isNotEmptyValidator
                                    ? const Icon(Icons.done) : null,
                                prefixIcon: Icons.person,
                                hint: "UserName",
                                errorText: (!state.userId.isNotEmptyValidator && state.verifyData)
                                    ? "Please ensure the user entered is valid" : null,
                                onChange: (v) {
                                  context.read<LoginBloc>().add(UserIdChanged(v));
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return AuthCustomTextfield(
                                obscureText: true,
                                suffixIcon: state.password.isPasswordValid
                                    ? const Icon(Icons.done) : null,
                                prefixIcon: Icons.lock,
                                hint: "Password",
                                errorText: !state.password.isPasswordValid && state.verifyData
                                    ? "Please ensure the password entered is valid" : null,
                                onChange: (v) {
                                  context.read<LoginBloc>().add(PasswordChanged(v));
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return ActionButton(
                                text: "Login",
                                state: state.state,
                                onPress: () {
                                  context.read<LoginBloc>().add(OnLogin());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSuccess() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const DashboardPage()));

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
