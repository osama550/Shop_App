import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/components/components.dart';
import 'package:shop/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop/modules/shop_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.name,
                      validate: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Empty text';
                        }
                        return null;
                      },
                        onSubmit:(String text)
                      {
                        if(formKey.currentState!.validate())
                        {
                          SearchCubit.get(context).search(text: text);
                        }

                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          // physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).searchModel!.data!.data[index],
                            context,
                            isOldPrice:false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
