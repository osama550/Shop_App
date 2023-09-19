import 'package:flutter/material.dart';
import 'package:shop/components/components.dart';
import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
 final String title;
 final  String body;
  BoardingModel({
   required this.image,
    required this.title,
    required this.body,

});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/image1.png',
        title:"On Board 1 Title" ,
        body: "On Board 1 Title",),
    BoardingModel(
      image: 'assets/images/image1.png',
      title:"On Board 2 Title" ,
      body: "On Board 2 Title",),
    BoardingModel(
      image: 'assets/images/image1.png',
      title:"On Board 3 Title" ,
      body: "On Board 3 Title",),
  ];
  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton
            (text: "SKIP",
              function:submit )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics:BouncingScrollPhysics(),
                controller:boardController ,
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                    isLast=true;
                     });
                        }else{
                    setState(() {
                      isLast=false;
                    });

                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
              itemCount:boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
               SmoothPageIndicator(
                   controller: boardController,
                   effect: ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     dotHeight: 10,
                     dotWidth: 10,
                     spacing: 5,
                     expansionFactor: 4,
                     activeDotColor: defaultColor,
                   ),
                   count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed:(){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(duration: Duration(
                        milliseconds: 750,
                      ), curve: Curves.fastLinearToSlowEaseIn,);
                    }

                  },
                  child:Icon(
                    Icons.arrow_forward_ios
                  ),),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model) =>Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'), ),
      ),
      SizedBox(
        height: 30,

      ),
      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 24.0,

        ),
      ),
      SizedBox(
        height: 15,

      ),
      Text(
        "${model.body}",
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
      SizedBox(
        height: 15,

      ),
    ],
  );
}
