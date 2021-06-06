import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';

class GoogleMapViw extends StatefulWidget {
  static const String routeName = '/google_map';

  @override
  State<GoogleMapViw> createState() => GoogleMapViwState();
}

class GoogleMapViwState extends State<GoogleMapViw> {
  double longitude;
  double latitude;

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  Future getSelectedPlace({String place}) async {
    List<Location> locations = await locationFromAddress(place);
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    final String place = ModalRoute.of(context).settings.arguments;
// AdmobBannerWidget(),
    return Scaffold(
      body: FutureBuilder(
        future: getSelectedPlace(place: place),
        builder: (context, projectSnap) {

          if (!projectSnap.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE7B5C1)),
                ));
          } else {
            List<Location> location = projectSnap.data;

            if (location == null) {
              return Center(
                child: Container(
                  child: Text(
                    "주소가 없어요!",
                    style: FontTheme.cR30Regular,
                  ),
                ),
              );
            } else {
              Iterable _markers = Iterable.generate(1, (index) {
                LatLng latLngMarker =
                LatLng(location[0].latitude, location[0].longitude);
                return Marker(
                    markerId: MarkerId("marker$index"), position: latLngMarker);
              });

              return Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target:
                      LatLng(location[0].latitude, location[0].longitude),
                      zoom: 18,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set.from(
                      _markers,
                    ),
                    myLocationButtonEnabled: false,
                  ),
                  SafeArea(child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: GestureDetector(
                      onTap: ()=>Navigator.of(context).pop(),
                      child: Container(
                        width: 50,
                        height:50,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ], shape: BoxShape.circle, color:  Color(0xFFE7B5C1),),
                        child: Center(
                            child: Icon(Icons.arrow_back_outlined)),
                      ),
                    ),
                  ),),
                ],
              );
            }
          }
        },
      )
    );
  }
}
