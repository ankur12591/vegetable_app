import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vegetable_app/Models/response.dart';
import 'package:vegetable_app/Screens/veg_details.dart';
import 'package:vegetable_app/Screens/veg_grid_view.dart';

class Vegetable extends StatefulWidget {
  @override
  _VegetableState createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
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

  // List<Response> parsePosts(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Response>((json) => Response.fromJson(json)).toList();
  // }
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
    var cellHeight = 281;

    return Scaffold(
      // backgroundColor: Colors.blueGrey,

      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            //padding: EdgeInsets.symmetric(),
            decoration: BoxDecoration(color: Color(0xffEEEEEE)),
          ),
          Container(
            //color: Colors.deepOrangeAccent,
            // padding: EdgeInsets.symmetric(horizontal: 15),
            // height: MediaQuery.of(context).size.height - 30 ,
            //width: MediaQuery.of(context).size.width,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Vegetables",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      //color: Colors.white,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: MediaQuery.of(context).size.height - 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffF9F9F9),
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(30, 30),
                              topLeft: Radius.elliptical(30, 30))),
                    ),
                    _loading
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            child:
                                Center(child: CircularProgressIndicator()),
                          )
                        : Container(
                            height:
                                MediaQuery.of(context).size.height - 100,

                            //height: 200,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            //  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),

                            child: GridView.builder(
                              itemCount: list.length,
                              //  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                               physics: ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 220,
                                mainAxisSpacing: 60.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: width / cellHeight,
                              ),
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    list[index]['images'].runtimeType ==
                                            String
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      index: index,
                                                      imageString:
                                                          list[index]
                                                              ['images'],
                                                      list: list,
                                                    )))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      index: index,
                                                      imageList: list[index]
                                                          ['images'],
                                                      list: list,
                                                    )));
                                  },
                                  child: Container(
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
                  ],
                ),
              ],
            ),
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
            'Fetching Data',
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
