import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              //padding: EdgeInsets.fromLTRB(16, 54, 30, 18),
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
            Column(
              children: [
                // widget.imageString == "" || widget.imageString == null?
                //Image.asset('images/place_holder.png',fit: BoxFit.cover) :
                // widget.imageList is List ?
                // getCarouselView(widget.imageList as List<dynamic>) :
                // Image.network(widget.imageString),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
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
            SizedBox(
              height: 30,
            ),
            Container(
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
        ),
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
}
