import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/components/components.dart';
import 'package:shop/components/constants.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop/modules/shop_app/register/cubit/state.dart';
import 'package:shop/network/local/cache_helper.dart';


class ShopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final  emailController = TextEditingController();
  final passwordController = TextEditingController();
  final  nameController = TextEditingController();
  final  phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(

        listener: ( context, state)
        {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel!.status!) {
              // print(state.loginModel!.message!);
              // print(state.loginModel!.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {
                token =  state.loginModel!.data!.token!;
                navigateAndFinish(
                  context,
                  ShopLayout(),);
              });



            }
            else {
              // print(state.loginModel!.message!);
              showToast(
                text: state.loginModel!.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: ( context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Register Now'),
            ),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black)),

                        Text(
                          'REGISTER now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,

                          validate: ( value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }return null;
                          }
                          ,
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,

                          validate: ( value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }return null;
                          }
                          ,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {

                            },
                            validate: (value) {
                              if (value!.isEmpty){
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,

                          validate: ( value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }return null;
                          }
                          ,
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        ConditionalBuilder(
                          condition:state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: 'register',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name:nameController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
