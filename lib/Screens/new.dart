import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vegetable_app/Models/response.dart';
import 'package:vegetable_app/Screens/veg_details.dart';
import 'package:vegetable_app/Screens/veg_grid_view.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String data;
  static bool isString = false;
  var list = [];
  bool _isInAsyncCall = false;
  bool _loading = false;

  Future<List<Response>> postCall() async {
    final String url =
        "http://php10.shaligraminfotech.com/Demo/public/api/get_practical_data";
    final response = await http.post(url, body: {"practical_type": "3"});
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        list = jsonDecode(data)['data']; //get all the data from json superheros
        print(list.length);
        _isInAsyncCall = true;
      });
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    postCall();
  }

  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 410;
    var _aspectRatio = width / cellHeight;

    return new Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 54, 30, 18),
              child: Row(
                children: [
                  Container(
                    //color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                   // margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                    height: 50,

                    //width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Vegetables",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                    ),
                    color: Color(0xFFF9F9F9),
                  ),
                  child: GridView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.symmetric(
                        vertical: 40, horizontal: 45),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: _aspectRatio),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          list[index]['images'].runtimeType ==
                              String
                              ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    index: index,
                                    imageString:
                                    list[index]
                                    ['images'],
                                    list: list,
                                  )))
                              : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    index: index,
                                    imageList: list[index]
                                    ['images'],
                                    list: list,
                                  )));
                        },
                        child: Container(
                          // color: Colors.greenAccent,
                          child: VegTile(
                            title: list[index]['title'],
                            description: list[index]
                            ['description'],
                            imgUrl: list[index]['images'],
                            price:
                            list[index]['price'].toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            )

          ],
        ),
      ),
    );
  }
}

// class Vegetable extends StatelessWidget {
//   final VegetableResponse response;

//   const Vegetable({Key key, this.response}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new Container(
//         constraints: new BoxConstraints.expand(),
//         color: new Color(0xFF736AB7),
//         child: new Stack(
//           children: <Widget>[
//             _getContent(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getContent() {
//     return new Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(16, 54, 30, 18),
//             child: Row(
//               children: <Widget>[
//                 SizedBox(
//                   height: 50,
//                   width: 22,
//                 ),
//                 Text(
//                   'Vegetables',
//                   style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(34),
//                   topRight: Radius.circular(34),
//                 ),
//                 color: Color(0xFFF9F9F9),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     color: Color(0xFFF9F9F9),
//                   ),
//                   GridView.count(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 2,
//                     mainAxisSpacing: 16,
//                     padding: EdgeInsets.symmetric(
//                       vertical: 24,
//                     ),
//                     shrinkWrap: true,
//                     physics: ClampingScrollPhysics(),
//                     children: List.generate(response.data.length, (index) {
//                       return CustomCard(
//                           /*          title: response.title,
//                         description: response.description,
//                         imgUrl: response.images,
//                         price: response.price,*/
//                           );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fetching Your Vegetable',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }
}
