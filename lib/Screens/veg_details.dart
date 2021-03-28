import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final List<dynamic> imageList;
  final String imageString;
  final list;

  DetailScreen({this.index, this.imageList, this.imageString, this.list});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            //    color: Colors.green,
            // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            padding: EdgeInsets.fromLTRB(16, 30, 20, 5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/left_arrow.svg",
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // color: Colors.green,
            height: 250,
            // color: Colors.orange,
            decoration: BoxDecoration(
              // color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),

            // Container(
            child: Column(
              children: [
                if (widget.imageString != "") ...[
                  if (widget.imageList == null) ...[
                    Container(
                      width: 400,
                      height: 200,
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      decoration: BoxDecoration(
                          //   color: Colors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.network(
                        widget.imageString,
                        fit: BoxFit.fill,
                        width: 400,
                        height: 200,
                      ),
                    ),
                  ] else ...[
                    getCarouselView(widget.imageList as List<dynamic>)
                  ]
                ] else ...[
                  Container(
                    height: 230,
                    child: Image.asset('assets/place_holder.png',
                        fit: BoxFit.fill, width: 1000),
                  ),
                ]
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                padding: EdgeInsets.fromLTRB(16, 10, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.list[widget.index]['title'],
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text("₹" + widget.list[widget.index]['price'].toString(),
                    style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFFFA4A0C),
                        fontWeight: FontWeight.w600))
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vitamins", style: buildTextStyleMedium()),
                SizedBox(
                  height: 10,
                ),
                _buildCircleAvatars(),
                SizedBox(
                  height: 25,
                ),
                Text('Minerals', style: buildTextStyleMedium()),
                Text(
                  widget.list[widget.index]['minerals'],
                  style: buildTextStyleLightGrey(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Description',
                  style: buildTextStyleMedium(),
                ),
                Text(
                  widget.list[widget.index]['description'],
                  style: buildTextStyleLightGrey(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Pros',
                  style: buildTextStyleMedium(),
                ),
                Container(
                    // color: Colors.green,
                    child: _prosList(widget.list[widget.index]['pros'])),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Cons',
                  style: buildTextStyleMedium(),
                ),
                _consList(widget.list[widget.index]['Cons']),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildCircleAvatars() {
    String optionString = widget.list[widget.index]['vitamins'];
    List<String> listString = optionString.split(",").toList();
    List<Widget> chips = new List();
    for (int i = 0; i < listString.length; i++) {
      Widget circle = Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFEBEBEB),
            child: ClipOval(
              child: Text(listString[i],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFA4A0C),
                  )),
            ),
            radius: 20,
          ),
          SizedBox(
            width: 15,
          )
        ],
      );
      chips.add(circle);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: chips,
    );
  }

  TextStyle buildTextStyleMedium() {
    return TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);
  }

  TextStyle buildTextStyleLightGrey() {
    return TextStyle(
        fontSize: 18,
        color: Colors.black38,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.02);
  }

  Widget _prosList(data) {
    return Container(
      child: ListView.builder(
          //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _greenTile(data[index]);
          }),
    );
  }

  Widget _greenTile(String title) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: 4),
      // visualDensity: VisualDensity(horizontal: 0, vertical: 4),
      contentPadding: EdgeInsets.all(0.0),
      title: Text(title,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.02)),
      leading: SvgPicture.asset(
        'assets/right_arrow_green.svg',
        width: 26.0,
        height: 26.0,
      ),
    );
  }

  ListView _consList(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _redTile(data[index]);
        });
  }

  ListTile _redTile(String title) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      title: Text(title,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.02)),
      leading: SvgPicture.asset(
        'assets/right_arrow_red.svg',
        width: 26.0,
        height: 26.0,
      ),
    );
  }

  Widget getCarouselView(List<dynamic> newList) {
    return Container(
      //color: Colors.green,
      child: GFCarousel(
        height: 250,
        autoPlay: true,
        pagination: true,
        viewportFraction: 1.0,
        activeIndicator: Color(0xFFFA4A0C),
        passiveIndicator: Color(0xFFC4C4C4),
        aspectRatio: 3,
        items: newList
            .map((item) => Container(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 45),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 500,
                      height: 250,
                    ),
                  )),
                ))
            .toList(),
        onPageChanged: (index) {
          setState(() {});
        },
      ),
    );
  }
}
