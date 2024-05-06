import 'package:covid_tracker/Models/Services/states_servies.dart';
import 'package:covid_tracker/Models/world_model_api.dart';
import 'package:covid_tracker/Screen/country_list.dart';
import 'package:covid_tracker/widgets/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScrren extends StatefulWidget {
  const WorldStatesScrren({Key? key}) : super(key: key);

  @override
  State<WorldStatesScrren> createState() => _WorldStatesScrrenState();
}

class _WorldStatesScrrenState extends State<WorldStatesScrren>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Color> colorList = [
    const Color(0xff4285F4),
    const Color(0xff428568),
    const Color(0xF4DC1068),
  ];

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  FutureBuilder(
                      future: stateService.fecthWorkStatesRecords(),
                      builder:
                          (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                        if (!snapshot.hasData) {
                          return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.teal,
                              size: 50,
                              controller: _controller,
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              PieChart(
                                dataMap: {
                                  "Total": double.parse(
                                      snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(
                                      snapshot.data!.recovered!.toString()),
                                  "Deaths": double.parse(
                                      snapshot.data!.deaths!.toString()),
                                },
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: const [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.red,
                                ],
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            .06),
                                child: Card(
                                  color: const Color(0xff1aa260),
                                  child: Column(
                                    children: [
                                      ReusableRow(
                                        title: 'Total',
                                        value: snapshot.data!.cases.toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Deaths',
                                        value: snapshot.data!.deaths.toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Recoverd',
                                        value:
                                            snapshot.data!.recovered.toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Active',
                                        value: snapshot.data!.active.toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Critiacal',
                                        value:
                                            snapshot.data!.critical.toString(),
                                      ),
                                      ReusableRow(
                                        title: 'TodayDeaths',
                                        value: snapshot.data!.todayDeaths
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'TodayRecovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Today Case',
                                        value: snapshot.data!.todayCases
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Cases Per One Million',
                                        value: snapshot.data!.casesPerOneMillion
                                            .toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Deaths Per One Million',
                                        value: snapshot
                                            .data!.deathsPerOneMillion
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Countrylist()));
                                },
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1aa260),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text("Track Countires"),
                                    )),
                              ),
                            ],
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
