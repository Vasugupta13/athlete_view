import 'dart:convert';
import 'package:athlete_app/const/consts.dart';
import 'package:athlete_app/model/ListModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Athlete extends StatefulWidget {
  const Athlete({super.key});

  @override
  State<Athlete> createState() => _AthleteState();
}

class _AthleteState extends State<Athlete> {
  @override
  void initState() {
    readJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            kAppBarText,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.grey[150],
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder<List<ListModel1>>(
                future: readJsonData(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(
                      child: Text("${data.error}"),
                    );
                  } else if (data.hasData) {
                    List<ListModel1> model = data.data!;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: 350,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: model[index].level == 'Basic'
                                          ? kBasicColor
                                          : model[index].level == 'Intermediate'
                                              ? kIntermediateColor
                                              : model[index].level == 'Advanced'
                                                  ? kAdvancedColor
                                                  : Colors.white,
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: model[index].level ==
                                                'Basic'
                                            ? kBasicColor
                                            : model[index].level == 'Intermediate'
                                                ? kIntermediateColor
                                                : model[index].level == 'Advanced'
                                                    ? kAdvancedColor
                                                    : Colors.white,
                                        radius: 108,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 100,
                                          child: CircleAvatar(
                                            radius: 95,
                                            backgroundImage:
                                                AssetImage(model[index].image!),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        model[index].name!,
                                        style: GoogleFonts.manrope(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff353434),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              width: double.infinity,
                                              height: 30,
                                              color: model[index].level == 'Basic'
                                                  ? kBasicColor
                                                  : model[index].level ==
                                                          'Intermediate'
                                                      ? kIntermediateColor
                                                      : model[index].level ==
                                                              'Advanced'
                                                          ? kAdvancedColor
                                                          : Colors.white,
                                            ),
                                          ),
                                          Positioned(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                model[index].level!,
                                                style: GoogleFonts.manrope(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  Future<List<ListModel1>> readJsonData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("json/athleteList.json");
    List mapData = jsonDecode(data);
    List<ListModel1> model =
        mapData.map((model) => ListModel1.fromJson(model)).toList();

    return model;
  }
}
