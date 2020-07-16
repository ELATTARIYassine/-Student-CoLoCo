import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/screens/create_demand.dart';
import 'package:flutter_exam/widgets/menu_drawer.dart';
import 'package:provider/provider.dart';
import 'create_offer.dart';
import 'package:flutter_exam/widgets/rating_stars.dart';
import 'package:flutter_exam/screens/housting_details.dart';
import 'package:flutter_exam/screens/demands.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    HousingNotifier housingNotifier =
        Provider.of<HousingNotifier>(context, listen: false);
    getHoustings(housingNotifier);
    print("-------------------------");
    print(housingNotifier.housingList);
    super.initState();
  }

  // @protected
  // @mustCallSuper
  // void didChangeDependencies() {
  //   HousingNotifier housingNotifier =
  //       Provider.of<HousingNotifier>(context, listen: false);
  //   getHoustings(housingNotifier);
  // }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    DemandNotifier demandNotifier = Provider.of<DemandNotifier>(context);

    Future<void> _refreshList() async {
      getHoustings(housingNotifier);
    }

    print("building Feed");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            authNotifier.user.displayName != null
                ? authNotifier.user.displayName
                : "Feed",
          ),
          actions: <Widget>[
            // action button
            FlatButton(
              onPressed: () => signout(authNotifier),
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
                  housingNotifier.currentHousing =
                      housingNotifier.housingList[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HoustingDetails(),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Hero(
                          tag: housingNotifier.housingList[index].image,
                          child: Image.network(
                              housingNotifier.housingList[index].image,
                              fit: BoxFit.fill, loadingBuilder:
                                  (BuildContext context, Widget child,
                                      ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          }, width: 150.0, height: 150.0),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                housingNotifier.housingList[index].title,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              RatingStarts(int.parse(
                                  housingNotifier.housingList[index].rating)),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                housingNotifier.housingList[index].address,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                housingNotifier.housingList[index].price +
                                    " MAD",
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
            itemCount: housingNotifier.housingList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
          onRefresh: _refreshList,
        ));
  }
}
