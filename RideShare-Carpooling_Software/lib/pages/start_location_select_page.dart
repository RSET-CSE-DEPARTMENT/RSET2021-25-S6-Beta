// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_place/google_place.dart';

// class StartLocationSelectPage extends StatefulWidget {
//   @override
//   State<StartLocationSelectPage> createState() =>
//       _StartLocationSelectPageState();
// }

// class _StartLocationSelectPageState extends State<StartLocationSelectPage> {
//   final _startSearchFieldController = TextEditingController();

//   DetailsResult? startPosition; //String startPosition = "";

//   late GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions =
//       []; //List<String> predictions = [];
//   Timer? _debounce;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         // predictions = [
//         //   "Kakkanad",
//         //   "Kakkanad Junction",
//         //   "Kakkanad Collectorate Signal Junction",
//         //   "Kakkanad Main Bus Stop",
//         //   "Kakkanad Info Park",
//         //   "Kakkanad Water Metro",
//         //   "Kalamassery",
//         //   "Kaloor",
//         //];
//         predictions = result.predictions!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           toolbarHeight: 70.0,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           title: TextField(
//             controller: _startSearchFieldController,
//             autofocus: true,
//             cursorColor: Colors.green,
//             style: TextStyle(fontSize: 18, height: 0.9),
//             decoration: InputDecoration(
//                 prefixIcon: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_outlined,
//                       size: 25,
//                       color: Colors.black87,
//                     )),
//                 isDense: true,
//                 hintText: 'Choose start location',
//                 hintStyle:
//                     const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(
//                       color: Colors.green,
//                     )),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(
//                       color: Colors.green,
//                     )),
//                 suffixIcon: _startSearchFieldController.text.isNotEmpty
//                     ? IconButton(
//                         onPressed: () {
//                           setState(() {
//                             predictions = [];
//                             _startSearchFieldController.clear();
//                           });
//                         },
//                         icon: Icon(
//                           Icons.clear_outlined,
//                           size: 22,
//                         ),
//                       )
//                     : null),
//             onChanged: (value) {
//               if (_debounce?.isActive ?? false) _debounce!.cancel();
//               _debounce = Timer(const Duration(milliseconds: 1000), () {
//                 if (value.isNotEmpty) {
//                   //places api
//                   autoCompleteSearch(value);
//                 } else {
//                   //clear out the results
//                   setState(() {
//                     predictions = [];
//                     startPosition = null;
//                   });
//                 }
//               });
//             },
//           )),
//       body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Expanded(
//             child: ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: predictions.length,
//                 separatorBuilder: (BuildContext context, int index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: const Divider(
//                         color: Colors.green,
//                         height: 0.0,
//                         indent: 68.0,
//                       ),
//                     ),
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       maxRadius: 17,
//                       backgroundColor: Colors.green[300],
//                       child: Icon(
//                         Icons.location_on_outlined,
//                         size: 22,
//                         color: Colors.white,
//                       ),
//                     ),
//                     trailing: Transform.flip(
//                       flipX: true,
//                       child: Icon(
//                         Icons.arrow_outward_outlined,
//                       ),
//                     ),
//                     title: Text(
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       predictions[index]
//                           .description
//                           .toString(), //predictions[index],
//                       style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
//                     ),
//                     subtitle: Text(
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       "Kakkanad, Kochi, Kerala, India, ajhkdfh",
//                       style: GoogleFonts.roboto(color: Colors.grey[600]),
//                     ),
//                     onTap: () async {
//                       final placeId = predictions[index].placeId!;
//                       final details = await googlePlace.details.get(placeId);
//                       if (details != null &&
//                           details.result != null &&
//                           mounted) {
//                         //if (startFocusNode.hasFocus) {
//                         setState(() {
//                           startPosition = details.result; //predictions[index];
//                         });
//                         if (startPosition != null /*&& endPosition != ""*/) {
//                           //*********replace "" with null************
//                           Navigator.pop(context, startPosition.toString());
//                         }
//                       }
//                     },
//                   );
//                 }),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
//import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
//import 'package:rideshare_flutter/search_results_page.dart';

class StartLocationSelectPage extends StatefulWidget {
  @override
  _StartLocationSelectPageState createState() =>
      _StartLocationSelectPageState();
}

class _StartLocationSelectPageState extends State<StartLocationSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          //center: LatLong(23, 89),
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            print('\n\n\n\n\n***************************************');
            print(pickedData.addressName);
            print(pickedData.latLong);
            print('\n\n\n\n\n***************************************');
            Navigator.pop(context, [
              pickedData.addressName,
              pickedData.latLong.latitude,
              pickedData.latLong.longitude
            ]);
          }),
    );
  }
}
