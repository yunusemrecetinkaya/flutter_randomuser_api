import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:deneme/models/api_model.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

class PersonDetail extends StatefulWidget {
  Result item;
  PersonDetail(Result item) {
    this.item = item;
  }

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: StreamBuilder(
          // This streamBuilder reads the real-time status of SlimyCard.

          initialData: false,
          stream: slimyCard.stream, //Stream of SlimyCard
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(height: 100),
                SlimyCard(
                  color: Colors.deepPurple[200],
                  // In topCardWidget below, imagePath changes according to the
                  // status of the SlimyCard(snapshot.data).
                  topCardWidget: topCardWidget((snapshot.data)
                      ? widget.item.picture.large
                      : widget.item.picture.large),
                  bottomCardWidget: bottomCardWidget(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: NetworkImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          '${widget.item.name.title} ${widget.item.name.first} ${widget.item.name.last}',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Text(
          '${widget.item.location.city} / ${widget.item.location.country}',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// EMAİL
        Expanded(
          child: ListTile(
            title: Text(
              widget.item.email,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.mail,
              color: Colors.white,
            ),
          ),
        ),
        Divider(color: Colors.white),

        /// BİRTHDAY
        Expanded(
          child: ListTile(
            title: Text(
              formatDate(widget.item.dob.date, [yyyy, '-', mm, '-', dd]),
              //widget.item.dob.date.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.cake,
              color: Colors.white,
            ),
          ),
        ),
        Divider(color: Colors.white),

        /// CELL
        Expanded(
          child: ListTile(
            title: Text(
              widget.item.cell,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
