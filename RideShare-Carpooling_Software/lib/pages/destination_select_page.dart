// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_place/google_place.dart';

// class DestinationSelectPage extends StatefulWidget {
//   @override
//   State<DestinationSelectPage> createState() => _DestinationSelectPageState();
// }

// class _DestinationSelectPageState extends State<DestinationSelectPage> {
//   final _endSearchFieldController = TextEditingController();
//   String endPosition = ""; //DetailsResult? endPosition;

//   late GooglePlace googlePlace;
//   List<String> predictions =
//       []; //List<AutocompletePrediction> predictions = [];
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     String apiKey = '';
//     googlePlace = GooglePlace(apiKey);
//   }

//   void autoCompleteSearch(String value) async {
//     //var result = await googlePlace.autocomplete.get(value);
//     if (mounted //result != null && result.predictions != null && mounted
//         ) {
//       setState(() {
//         predictions = [
//           "Kakkanad",
//           "Vytilla",
//           "Edapalli",
//           "Kalamassery",
//           "Nedumbassery",
//           "Vytilla",
//           "Edapalli",
//           "Kalamassery",
//           "Nedumbassery",
//           "A very big place name that is too big to fit in the texfield"
//         ]; //predictions = result.predictions!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70.0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: TextField(
//             controller: _endSearchFieldController,
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
//                 hintText: 'Choose destination',
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
//                 suffixIcon: _endSearchFieldController.text.isNotEmpty
//                     ? IconButton(
//                         onPressed: () {
//                           setState(() {
//                             predictions = [];
//                             _endSearchFieldController.clear();
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
//                     endPosition = ""; //null;
//                   });
//                 }
//               });
//             },
//           ),
//         ),
//       ),
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
//                       predictions[
//                           index], //predictions[index].description.toString(),
//                       style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
//                     ),
//                     subtitle: Text(
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       "Kakkanad, Kochi, Kerala, India, ajhkdfh",
//                       style: GoogleFonts.roboto(color: Colors.grey[600]),
//                     ),
//                     onTap: () async {
//                       //final placeId = predictions[index].placeId!;
//                       //final details = await googlePlace.details.get(placeId);
//                       if ( //details != null &&
//                           //details.result != null &&
//                           mounted) {
//                         //if (startFocusNode.hasFocus) {
//                         setState(() {
//                           endPosition = predictions[index]; //details.result;
//                         });
//                         if (endPosition != "" /*&& endPosition != ""*/) {
//                           //*********replace "" with null************
//                           Navigator.pop(context, endPosition);
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

class DestinationSelectPage extends StatefulWidget {
  @override
  _DestinationSelectPageState createState() => _DestinationSelectPageState();
}

class _DestinationSelectPageState extends State<DestinationSelectPage> {
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
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
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
