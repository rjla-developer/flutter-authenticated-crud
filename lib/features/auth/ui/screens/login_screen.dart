import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/core/ui/shared/shared.dart';
import 'package:teslo_shop/features/auth/presenter/bloc/login_form_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Icon Banner
            const Icon(
              Icons.production_quantity_limits_rounded,
              color: Colors.white,
              size: 100,
            ),
            const SizedBox(height: 80),

            Container(
              height: size.height - 260, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            )
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text('Login', style: textStyles.titleLarge),
              const SizedBox(height: 90),
              CustomTextFormField(
                label: 'Correo',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<LoginFormBloc>().add(UserModelChanged(value)),
                errorMessage: state.email.errorMessage,
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                onChanged: (value) =>
                    context.read<LoginFormBloc>().add(PasswordChanged(value)),
                errorMessage: state.password.errorMessage,
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomFilledButton(
                    text: 'Ingresar',
                    buttonColor: Colors.black,
                    onPressed: state.email.isValid && state.password.isValid
                        ? () {
                            context.read<LoginFormBloc>().add(FormSubmitted());
                          }
                        : null,
                  )),
              const Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes cuenta?'),
                  TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('Crea una aquí'))
                ],
              ),
              const Spacer(flex: 1),
            ],
          ),
        );
      },
    );
  }
}
