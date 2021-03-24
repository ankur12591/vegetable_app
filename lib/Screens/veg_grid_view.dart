import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VegTile extends StatelessWidget {
  final String title;
  final String price;
  final dynamic imgUrl;
  final String description;

  VegTile({this.title, this.price, this.imgUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            // SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(
                top: 50,
                //top: 108 / 2.0,
              ),
              child: Container(
                //height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        // padding: const EdgeInsets.fromLTRB(0,10,0,0),

                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Container(
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              child: Text(
                                "₹" + price,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 16),
                              child: Text(
                                description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                softWrap: false,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              alignment: Alignment.center,
              width: 110,
              height: 110,
              //padding: const EdgeInsets.symmetric(horizontal:0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //color: Colors.green,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              //child: _image(),
              child: _imageView(),
            )
          ],
        ),
      ],
    );
  }


  Widget _imageView() {
    if (imgUrl == null || imgUrl == "") {
      return Container(
        child: CircleAvatar(
          maxRadius: 56,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/place_holder.png'),
        ),
      );
    } else if (imgUrl is List) {
      return Container(
        child: CircleAvatar(
          maxRadius: 56,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imgUrl.first),
        ),
      );
    } else {
      return Container(
        child: CircleAvatar(
          maxRadius: 56,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imgUrl),
        ),
      );
    }
  }
}
