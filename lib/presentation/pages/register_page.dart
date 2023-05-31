import 'package:fic4_tugas_akhir_ekatalog/bloc/register/register_bloc.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/register/register_event.dart';
import 'package:fic4_tugas_akhir_ekatalog/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/register/register_state.dart';
import '../../data/models/request/register_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Name'),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: emailController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Password'),
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 16,
          ),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoaded) {
                nameController!.clear();
                emailController!.clear();
                passwordController!.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue,
                  content: Text('Register Success with id : ${state.model.id}'),
                ));
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  final requestModel = RegisterModel(
                    name: nameController!.text,
                    email: emailController!.text,
                    password: passwordController!.text,
                  );
                  context
                      .read<RegisterBloc>()
                      .add(SaveRegisterEvent(request: requestModel));
                },
                child: const Text('Register'),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
              );
            },
            child: const Text('Belum Punya Akun? Register',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
        ]),
      ),
    );
  }
}
