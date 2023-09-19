import 'package:shop/components/components.dart';
import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeDate(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}
dynamic token = '';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
