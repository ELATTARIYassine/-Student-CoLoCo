import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/widgets/menu_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/screens/demand_details.dart';
import 'create_demand.dart';
import 'create_offer.dart';
import 'housting_details.dart';

class demandsFeed extends StatefulWidget {
  @override
  _demandsFeedState createState() => _demandsFeedState();
}

class _demandsFeedState extends State<demandsFeed> {
  @override
  void initState() {
    DemandNotifier demandNotifier =
        Provider.of<DemandNotifier>(context, listen: false);
    getDemands(demandNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    DemandNotifier demandNotifier = Provider.of<DemandNotifier>(context);

    Future<void> _refreshList() async {
      getDemands(demandNotifier);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
              //authNotifier.user != null ? authNotifier.user.displayName : "Feed",
              'Demands List'),
          actions: <Widget>[
            // action button
            FlatButton(
              // onPressed: () => signout(authNotifier),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        drawer: MenuDrawerHousing(
            housingNotifier: housingNotifier,
            demandNotifier: demandNotifier,
            authNotifier: authNotifier),
        body: RefreshIndicator(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              // return ListTile(
              //   title: Text(housingNotifier.housingList[index].title),
              //   subtitle: Text(housingNotifier.housingList[index].address),
              //   leading: NetworkImage(Image(image: "erzer",)),
              // );
              return GestureDetector(
                onTap: () {
                  demandNotifier.currentDemand =
                      demandNotifier.demandList[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DemandDetails(),
                    ),
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.grey[200],
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                demandNotifier.demandList[index].fullname,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                demandNotifier.demandList[index].budget +
                                    " MAD",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                demandNotifier.demandList[index].phone,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: demandNotifier.demandList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.white,
              );
            },
          ),
          onRefresh: _refreshList,
        ));
  }
}
