import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:cifo_flutter/features/register/presentation/bloc/register_bloc.dart';
import 'package:cifo_flutter/shared/widgets/custom_elevated_button_widget.dart';
import 'package:cifo_flutter/shared/widgets/custom_password_form_field_widget.dart';
import 'package:cifo_flutter/shared/widgets/custom_text_form_field_widget.dart';

import 'dart:js' as js;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurName = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  bool _obscurePassword = true;
  bool _chechBox = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
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
        } else if (state is RegisterCompletedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: const Text("Registrado correctamente"),
            ),
          );
          _formKey.currentState?.reset();
          Navigator.pop(context);
        } else if (state is RegisterErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Hubo un error'),
                content: Text(state.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterInitialState ||
            state is RegisterLoadingState ||
            state is RegisterErrorState) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "Registro",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Crea tu cuenta",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 35),
                    CustomTextFormField(
                      textController: _controllerId,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.number,
                      labelText: "Cedula",
                      iconData: Icons.assignment_ind_outlined,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, pon tu cedula";
                        } else if (int.tryParse(value) == null) {
                          return "Cedula Invalida";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      textController: _controllerName,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.name,
                      labelText: "Nombre",
                      iconData: Icons.person_outline,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, pon tu Nombre";
                        } else if (value.length <= 3) {
                          return "Por favor, pon tu Nombre";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      textController: _controllerSurName,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.name,
                      labelText: "Apellido",
                      iconData: Icons.person_outline,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, pon tu Apellido";
                        } else if (value.length <= 3) {
                          return "Por favor, pon tu Apellido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                     textController: _controllerNumber,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.number,
                      labelText: "Numero de Celular",
                      iconData: Icons.phone_outlined,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, pon tu Numero de celular";
                        } else if (int.tryParse(value) == null) {
                          return "Numero Invalid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      textController: _controllerAddress,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.streetAddress,
                      labelText: "Direccion",
                      iconData: Icons.room_outlined,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, pon tu direccion";
                        } else if (value.length < 8) {
                          return "Direccion Invalida";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      textController: _controllerEmail,
                      focusNode: _focusNodeEmail,
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
                                : const Icon(Icons.visibility_off_outlined))),
                    const SizedBox(height: 10),
                    CustomPasswordFormField(
                        textController: _controllerConFirmPassword,
                        focusNodeEmail: _focusNodeConfirmPassword,
                        labelText: "Confirmar clave",
                        iconData: Icons.password_outlined,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, ingrese clave.";
                          } else if (value != _controllerPassword.text) {
                            return "La clave no coincide.";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscurePassword),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextFormField(),
                        Checkbox(
                            value: _chechBox,
                            onChanged: (value) {
                              setState(() {
                                _chechBox = value!;
                              });
                            }),
                        const Text("Aceptar los"),
                        TextButton(
                          onPressed: () {
                            js.context.callMethod('open', ['https://www.minambiente.gov.co/politica-de-proteccion-de-datos-personales/#:~:text=Ley%20de%20Protecci%C3%B3n%20de%20Datos,de%20naturaleza%20p%C3%BAblica%20o%20privada.']);
                          },
                          child: const Text("terminos y condiciones"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        CustomElevatedButton(
                            text: "Registrar",
                            onPressed: () {
                              if (_chechBox) {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<RegisterBloc>().add(
                                        RegisterUserEvent(
                                          phoneNumber: _controllerNumber.text,
                                            surname: _controllerSurName.text,
                                            name: _controllerName.text,
                                            address: _controllerAddress.text,
                                            email: _controllerEmail.text,
                                            password: _controllerPassword.text,
                                            id: _controllerId.text),
                                      );
                                }
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿Ya tienes una cuenta?"),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Acceder"),
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
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerId.dispose();
    _controllerName.dispose();
    _controllerAddress.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
