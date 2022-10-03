import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/rent.dart';
import '../../screens/scan_page.dart';
import 'rent_box.dart';
import 'rented_box.dart';

Future<List<Rent>> _fetchRentList() async {
  final url = Uri.parse('http://p-cube-plus.com/rent/list');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(json.decode(response.body).runtimeType);
    return (json.decode(response.body) as List)
        .map((data) => Rent.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load post');
  }
}

class RentItemListView extends StatefulWidget {
  @override
  State<RentItemListView> createState() => RentItemListViewState();
}

class RentItemListViewState extends State<RentItemListView> {
  late Future<List<Rent>> rentAPI;

  @override
  void initState() {
    super.initState();
    rentAPI = _fetchRentList();
    RentBox.groupNum = -1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rent>>(
      future: rentAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RentBox(
                          rent: snapshot.data![index], isActive: true);
                    }),
              ),
              RentButton(text: "대여하기")
            ],
          );
        } else if (snapshot.hasError) {
          return Text("이상해");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class RentedItemListView extends StatefulWidget {
  @override
  State<RentedItemListView> createState() => RentedItemListViewState();
}

class RentedItemListViewState extends State<RentedItemListView> {
  late Future<List<Rent>> rentAPI;

  @override
  void initState() {
    super.initState();
    rentAPI = _fetchRentList();
    RentedBox.groupNum = -1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Rent>>(
      future: rentAPI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 231,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RentedBox(rent: snapshot.data![index]);
                        }),
                  ),
                  RentButton(text: "반납하기")
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("이상해");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class RentButton extends StatelessWidget {
  const RentButton({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ScanPage();
            }));
          },
          child: Text(
            text,
            style: theme.textTheme.headline1!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: theme.elevatedButtonTheme.style),
    );
  }
}
