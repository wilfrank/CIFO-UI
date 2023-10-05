import 'package:cifo_flutter/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifo_flutter/shared/widgets/custom_elevated_button_widget.dart';
import 'package:cifo_flutter/shared/widgets/custom_password_form_field_widget.dart';
import 'package:cifo_flutter/shared/widgets/custom_text_form_field_widget.dart';
import 'package:cifo_flutter/features/signin/presentation/bloc/sign_in_bloc.dart';
import 'package:cifo_flutter/features/register/presentation/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                content: Center(
                  child: CircularProgressIndicator(),
                ),
                surfaceTintColor: Colors.transparent,
              );
            },
          );
        } else if (state is SignInErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Ups algo salio mal...'),
                content:  Text(state.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); //Pop Error
                      Navigator.pop(context); //Pop Loading
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        } else if (state is SignedInUserState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignInInitialState ||
            state is SignInLoadingState ||
            state is SignInErrorState) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      "CiFo",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Citizen Folder (Carpeta Ciudadana)",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Accede a tu cuenta",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 60),
                    CustomTextFormField(
                      textController: _controllerUsername,
                      focusNode: _focusNodePassword,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Correo",
                      iconData: Icons.email_outlined,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, agrega un correo";
                        } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return "Correo Invalido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomPasswordFormField(
                      textController: _controllerPassword,
                      focusNodeEmail: _focusNodePassword,
                      labelText: "Clave",
                      iconData: Icons.password_outlined,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese clave.";
                        } else if (value.length < 8) {
                          return "La clave debe tener minimo 8 caracteres";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: _obscurePassword
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined)),
                    ),
                    const SizedBox(height: 60),
                    Column(
                      children: [
                        CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<SignInBloc>().add(
                                      SignInUserEvent(
                                        cedula: _controllerUsername.text,
                                        password: _controllerPassword.text,
                                      ),
                                    );
                              }
                            },
                            text: "Accede"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿No tienes una cuenta?"),
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const RegisterScreen();
                                    },
                                  ),
                                );
                              },
                              child: const Text("Registrate"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
