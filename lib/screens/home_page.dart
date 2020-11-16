import 'dart:ui';

import 'package:deneme/models/api_model.dart';
import 'package:deneme/screens/person_dateil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ApiModel> modelim;

  Future<ApiModel> verileriAl() async {
    final link = 'https://randomuser.me/api/?results=20';

    final response = await http.get(link);

    if (response.statusCode == 200) {
      return apiModelFromJson(response.body);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    modelim = verileriAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text('Person List'),
        centerTitle: true,
      ),
      body: FutureBuilder<ApiModel>(
        future: modelim,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            default:
              if (snapshot.hasError) {
                return Text('ERROR =>>>> ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context, index) {
                    List<Result> listem = snapshot.data.results;
                    Result item = listem[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PersonDetail(item)));
                      },
                      child: ListTile(
                        title: Text('${item.name.first} ${item.name.last}'),
                        subtitle: Text('Country: ${item.location.country}'),
                        leading: ClipOval(
                          child: Image.network(item.picture.thumbnail),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.deepPurple[200],
                        ),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
