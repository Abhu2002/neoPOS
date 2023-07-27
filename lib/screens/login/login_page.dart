
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neopos/utils/utils.dart';
import '../../utils/action_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_outlined_button.dart';
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
    context.read<LoginBloc>().onLoginSuccess = onSuccess;

    context.read<LoginBloc>().showMessage = createSnackBar;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            child:Column(
              children: [
                Expanded(
                    child: Stack(
                      children: [
                        SvgPicture.asset("assets/login_background.svg",
                            fit: BoxFit.fill),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Welcome \nback",
                                style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              )),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextField(
                            key: const Key("emailInput"),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                suffixIcon: state.email.isEmailValid
                                    ? const Icon(Icons.done)
                                    : null,
                                hintText: "Email",
                                helperText:
                                "A complete, valid email e.g. joe@gmail.com",
                                errorText:
                                    !state.email.isEmailValid&&state.verifyData
                                    ? "Please ensure the email entered is valid"
                                    : null),
                            onChanged: (v) {
                              context.read<LoginBloc>().add(EmailChanged(v));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextField(
                            key: const Key("passwordInput"),
                            obscureText: true,
                            decoration: InputDecoration(
                                suffixIcon: state.password.isPasswordValid
                                    ? const Icon(Icons.done)
                                    : null,
                                prefixIcon: const Icon(Icons.lock),
                                hintText: "Password",
                                helperText: "Password must be 8 more letters",
                                errorText:
                                    !state.password.isPasswordValid&&state.verifyData
                                    ? "Please ensure the password entered is valid"
                                    : null),
                            onChanged: (v) {
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
                            onPress: (){
                              context.read<LoginBloc>().add(OnLogin());
                            },
                          );
                        },
                      ),
                    ],
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
    final snackBar =  SnackBar(content:  Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

