import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_app/search_model.dart';
import 'package:shop/modules/shop_app/search/cubit/states.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/network/remote/end_points.dart';

import '../../../../components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel ;

  void search({
    required String text ,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      lang: 'en',
      data:
      {
        'text':text,
      },
      token: token ,
    ).then((value)
    {

      searchModel = SearchModel.fromJson(value.data);


      emit(SearchSuccessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(SearchErrorState(error.toString()),);
    });
  }
}