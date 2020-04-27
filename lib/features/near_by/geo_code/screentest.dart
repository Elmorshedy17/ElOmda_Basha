import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:momentoo/features/near_by/geo_code/geo_code_model.dart';
import 'dart:convert';
import 'package:momentoo/features/near_by/cities/_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class codetest extends StatefulWidget {
  @override
  _codetestState createState() => _codetestState();
}

class _codetestState extends State<codetest> {
  Future<String> _loadGeoCodeJsonAsset() async {
    return await rootBundle.loadString('assets/goecode.json');
  }

  List adressesCity = [];
  List formattedAddress = [];
  var manualcityIdChosen;

  Future<GeoCodeModel> loadGeoCodeJson() async {
    String jsonString = await _loadGeoCodeJsonAsset();
    final jsonResponse = json.decode(jsonString);
    return new GeoCodeModel.fromJson(jsonResponse);
  }

//  List hmm = [
//    {
//      "plus_code": {
//        "compound_code": "83HF+F2 Salmiya, Kuwait",
//        "global_code": "7HXC83HF+F2"
//      },
//      "results": [
//        {
//          "address_components": [
//            {
//              "long_name": "11",
//              "short_name": "11",
//              "types": [
//                "street_number"
//              ]
//            },
//            {
//              "long_name": "Al Mughira Bin Shu'ba Street",
//              "short_name": "Al Mughira Bin Shu'ba St",
//              "types": [
//                "route"
//              ]
//            },
//            {
//              "long_name": "Salmiya",
//              "short_name": "Salmiya",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "11 Al Mughira Bin Shu'ba St, Salmiya, Kuwait",
//          "geometry": {
//            "location": {
//              "lat": 29.3287374,
//              "lng": 48.0725604
//            },
//            "location_type": "ROOFTOP",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3300863802915,
//                "lng": 48.0739093802915
//              },
//              "southwest": {
//                "lat": 29.3273884197085,
//                "lng": 48.0712114197085
//              }
//            }
//          },
//          "place_id": "ChIJoy9lVvKdzz8RZdfi1Ids2Tc",
//          "plus_code": {
//            "compound_code": "83HF+F2 Salmiya, Kuwait",
//            "global_code": "7HXC83HF+F2"
//          },
//          "types": [
//            "street_address"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "11",
//              "short_name": "11",
//              "types": [
//                "street_number"
//              ]
//            },
//            {
//              "long_name": "شارع المغيرة بن شعبة",
//              "short_name": "شارع المغيرة بن شعبة",
//              "types": [
//                "route"
//              ]
//            },
//            {
//              "long_name": "السالمية",
//              "short_name": "السالمية",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "حولي",
//              "short_name": "حولي",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "Block 10 st, 11 شارع المغيرة بن شعبة، السالمية، Kuwait",
//          "geometry": {
//            "location": {
//              "lat": 29.3287423,
//              "lng": 48.0725563
//            },
//            "location_type": "ROOFTOP",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3300912802915,
//                "lng": 48.0739052802915
//              },
//              "southwest": {
//                "lat": 29.3273933197085,
//                "lng": 48.0712073197085
//              }
//            }
//          },
//          "place_id": "ChIJu2oX8PKdzz8R2LZ3UmMiW50",
//          "plus_code": {
//            "compound_code": "83HF+F2 Salmiya, Kuwait",
//            "global_code": "7HXC83HF+F2"
//          },
//          "types": [
//            "establishment",
//            "point_of_interest",
//            "spa"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "11 Street",
//              "short_name": "11 St",
//              "types": [
//                "route"
//              ]
//            },
//            {
//              "long_name": "Salmiya",
//              "short_name": "Salmiya",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "11 St, Salmiya, Kuwait",
//          "geometry": {
//            "bounds": {
//              "northeast": {
//                "lat": 29.3287095,
//                "lng": 48.0725996
//              },
//              "southwest": {
//                "lat": 29.3279274,
//                "lng": 48.0715773
//              }
//            },
//            "location": {
//              "lat": 29.3283065,
//              "lng": 48.0721009
//            },
//            "location_type": "GEOMETRIC_CENTER",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3296674302915,
//                "lng": 48.0734374302915
//              },
//              "southwest": {
//                "lat": 29.3269694697085,
//                "lng": 48.07073946970851
//              }
//            }
//          },
//          "place_id": "ChIJc2CQVvKdzz8R8ImH9rgOd7g",
//          "types": [
//            "route"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "1",
//              "short_name": "1",
//              "types": [
//                "street_number"
//              ]
//            },
//            {
//              "long_name": "11 Street 1 Lane",
//              "short_name": "11 Street 1 Ln",
//              "types": [
//                "route"
//              ]
//            },
//            {
//              "long_name": "Salmiya",
//              "short_name": "Salmiya",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "1 11 Street 1 Ln, Salmiya, Kuwait",
//          "geometry": {
//            "location": {
//              "lat": 29.3289567,
//              "lng": 48.0718357
//            },
//            "location_type": "RANGE_INTERPOLATED",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3303056802915,
//                "lng": 48.0731846802915
//              },
//              "southwest": {
//                "lat": 29.3276077197085,
//                "lng": 48.07048671970851
//              }
//            }
//          },
//          "place_id": "EiExIDExIFN0cmVldCAxIExuLCBTYWxtaXlhLCBLdXdhaXQiGhIYChQKEgn9bXeL8p3PPxG0_cxTculrsxAB",
//          "types": [
//            "street_address"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "Block 10",
//              "short_name": "Block 10",
//              "types": [
//                "neighborhood",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Salmiya",
//              "short_name": "Salmiya",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "Block 10, Salmiya, Kuwait",
//          "geometry": {
//            "bounds": {
//              "northeast": {
//                "lat": 29.3326521,
//                "lng": 48.0778671
//              },
//              "southwest": {
//                "lat": 29.3207961,
//                "lng": 48.054564
//              }
//            },
//            "location": {
//              "lat": 29.3270885,
//              "lng": 48.0679507
//            },
//            "location_type": "APPROXIMATE",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3326521,
//                "lng": 48.0778671
//              },
//              "southwest": {
//                "lat": 29.3207961,
//                "lng": 48.054564
//              }
//            }
//          },
//          "place_id": "ChIJryYtj-ydzz8RjjJag3kYi2Y",
//          "types": [
//            "neighborhood",
//            "political"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "Salmiya",
//              "short_name": "Salmiya",
//              "types": [
//                "locality",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "Salmiya, Kuwait",
//          "geometry": {
//            "bounds": {
//              "northeast": {
//                "lat": 29.3526523,
//                "lng": 48.1018112
//              },
//              "southwest": {
//                "lat": 29.3142565,
//                "lng": 48.0327901
//              }
//            },
//            "location": {
//              "lat": 29.3352938,
//              "lng": 48.0715612
//            },
//            "location_type": "APPROXIMATE",
//            "viewport": {
//              "northeast": {
//                "lat": 29.3526523,
//                "lng": 48.1018112
//              },
//              "southwest": {
//                "lat": 29.3142565,
//                "lng": 48.0327901
//              }
//            }
//          },
//          "place_id": "ChIJCfSwzCF2zz8R9wdSEnOEe9Y",
//          "types": [
//            "locality",
//            "political"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "Hawalli Governorate",
//              "short_name": "Hawalli Governorate",
//              "types": [
//                "administrative_area_level_1",
//                "political"
//              ]
//            },
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "Hawalli Governorate, Kuwait",
//          "geometry": {
//            "bounds": {
//              "northeast": {
//                "lat": 29.355482,
//                "lng": 48.10236399999999
//              },
//              "southwest": {
//                "lat": 29.2650789,
//                "lng": 47.976985
//              }
//            },
//            "location": {
//              "lat": 29.3056716,
//              "lng": 48.03076129999999
//            },
//            "location_type": "APPROXIMATE",
//            "viewport": {
//              "northeast": {
//                "lat": 29.355482,
//                "lng": 48.10236399999999
//              },
//              "southwest": {
//                "lat": 29.2650789,
//                "lng": 47.976985
//              }
//            }
//          },
//          "place_id": "ChIJ9y4wzsydzz8RRjWrvMeem-w",
//          "types": [
//            "administrative_area_level_1",
//            "political"
//          ]
//        },
//        {
//          "address_components": [
//            {
//              "long_name": "Kuwait",
//              "short_name": "KW",
//              "types": [
//                "country",
//                "political"
//              ]
//            }
//          ],
//          "formatted_address": "Kuwait",
//          "geometry": {
//            "bounds": {
//              "northeast": {
//                "lat": 30.1036993,
//                "lng": 48.5184
//              },
//              "southwest": {
//                "lat": 28.5244463,
//                "lng": 46.55303989999999
//              }
//            },
//            "location": {
//              "lat": 29.31166,
//              "lng": 47.481766
//            },
//            "location_type": "APPROXIMATE",
//            "viewport": {
//              "northeast": {
//                "lat": 30.1036993,
//                "lng": 48.5184
//              },
//              "southwest": {
//                "lat": 28.5244463,
//                "lng": 46.55303989999999
//              }
//            }
//          },
//          "place_id": "ChIJoVHqvj82xT8R0u3Yks1rcnQ",
//          "types": [
//            "country",
//            "political"
//          ]
//        }
//      ],
//      "status": "OK"
//    }
//  ];

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        body: Container(
          child: Center(
            child: RaisedButton(
              child: Text("click"),
              onPressed: () async {
//            await geoCodeRepo.geoCode(29.382820,47.989191).then((onValue){
//                print("onValueonValueonValueonValueonValueonValue ${onValue.status}");
//              });

                citiesRepo.getcitiesData().then((onCities) async {
                  await loadGeoCodeJson().then((onValue) {
//               print("onValueonValue${onValue.results[0].addressComponents[1].longName}");

                    if (onValue.status == "OK") {
                      for (int i = 0; i < 2; i++) {
                        if (onValue.results.length == 0 ||
                            i > onValue.results.length - 1) {
                          print("hahahaho ");
                        } else {
                          var addressComponents =
                              onValue.results[i].addressComponents;
                          addressComponents.forEach((f) {
                            if (f.types[0] == "locality" ||
                                f.types[0] == "political") {
//                        Adresses.clear();
                              print(f.longName[0]);
//                        print(Adresses);
                              adressesCity.remove(f.longName);
                              adressesCity.add(f.longName);
                            }
                          });
                        }
                        formattedAddress
                            .remove(onValue.results[i].formattedAddress);
                        formattedAddress
                            .add(onValue.results[i].formattedAddress);
                      }
                      print(
                          " Adresses  ${locator<PrefsService>().appLanguage == "ar" ? adressesCity[0] : adressesCity[1]}");
                      print("formatted_address ${formattedAddress[1]}");

                      for (int index = 0;
                          index < onCities.data.cities.length;
                          index++) {
                        if (adressesCity[0] ==
                            onCities.data.cities[index].name) {
                          print(
                              "ya rab ya karim ${onCities.data.cities[index].id}");
                          manualcityIdChosen = onCities.data.cities[index].id;
                        }
                      }
                    }
                  });
                });

//    print("hello ${hmm[].length}");

//    for (int index = 0;index < hmm.length;index++) {
//
//    }

                print("vip manualcityIdChosen $manualcityIdChosen");
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Address {
  double lat = 0.0;
  double lng = 0.0;
  var country = "";
  var governorate = "";
  var city = "";
  var street = "";
  var block = "";
}
//
//private fun handleResults(results: List<Result>, lat: Double, lng: Double): Address {
//var country = ""
//var governorate = ""
//var city = ""
//var street = ""
//var block = ""
//val address = Address()
//for (i in 0..1) {
//if (results.isEmpty() || i > results.size - 1) {
//break
//}
//val addressComponents = results[i].addressComponents
//for (index in addressComponents.indices) {
//when (addressComponents[index].types[0]) {
//"neighborhood" // Block
//-> if (block.isEmpty()) {
//block = addressComponents[index].longName
//address.block = block
//}
//"route" // Street
//-> if (street.isEmpty()) {
//street = addressComponents[index].longName
//address.street = street
//}
//"locality", "political" // City
//-> if (city.isEmpty()) {
//city = addressComponents[index].longName
//address.city = city
//} else if (city == "Kuwait City" && governorate != "Al Asimah Governate") {
//city = addressComponents[index].longName
//address.city = city
//}
//"administrative_area_level_1" // Governorate
//-> if (governorate.isEmpty()) {
//governorate = addressComponents[index].longName
//address.governorate = governorate
//}
//"country" // Country
//-> if (country.isEmpty()) {
//country = addressComponents[index].longName
//address.country = country
//}
//}
//}
//}
//return address
//}
