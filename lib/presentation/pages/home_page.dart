// ignore_for_file: use_build_context_synchronously

import 'package:fic4_tugas_akhir_ekatalog/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/profile/profile_event.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/profile/profile_state.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/localsources/auth_local_storage.dart';
import 'package:fic4_tugas_akhir_ekatalog/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/create_product/create_product_event.dart';
import '../../bloc/product/create_product/create_product_state.dart';
import '../../bloc/product/get_all_product/gel_all_product_bloc.dart';
import '../../bloc/product/get_all_product/get_all_product_event.dart';
import '../../bloc/product/get_all_product/get_all_product_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../data/models/request/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthLocalStorage().removeToken();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(children: [
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.profile.name ?? ''),
                const SizedBox(
                  width: 8,
                ),
                Text(state.profile.email ?? ''),
              ],
            );
          }
          return const Text('no data');
        }),
        Expanded(child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
            builder: (context, state) {
          if (state is GetAllProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetAllProductLoaded) {
            return ListView.builder(itemBuilder: ((context, index) {
              final product = state.listProducts.reversed.toList()[index];
              return Card(
                  child: ListTile(
                leading: CircleAvatar(
                  child: Text('${product.price}'),
                ),
                subtitle: Text(product.description ?? ''),
                title: Text(product.title ?? ''),
              ));
            }));
          }
          return const Text('no data');
        }))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Product'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  BlocListener<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                    if (state is CreateProductLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${state.productResponseModel.id}')),
                      );
                      Navigator.pop(context);
                      context
                          .read<GetAllProductBloc>()
                          .add(DoGetAllProductEvent());
                    }
                  }, child: BlocBuilder<CreateProductBloc, CreateProductState>(
                          builder: (context, state) {
                    if (state is CreateProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        final productModel = ProductModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          price: int.parse(
                            priceController.text,
                          ),
                        );
                        context.read<CreateProductBloc>().add(
                            DoCreateProductEvent(productModel: productModel));
                      },
                      child: const Text('Save'),
                    );
                  })),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
