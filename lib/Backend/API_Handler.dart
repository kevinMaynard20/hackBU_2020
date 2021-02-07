import 'WikiAPI.dart';
import 'LocationDoc.dart';
import 'YelpAPI.dart';


class APIHandler {

   static Future<List<LocationDoc>> getLocationInfo(coords) async {
     var masterList = [];
     
     //Get wikipedia pages
     var wikiList = await getWikiPages(coords);
     wikiList = trim(wikiList, 4);
     masterList.addAll(wikiList);

     var yelpList = await getYelpPages(coords); 
     yelpList = trim(yelpList, 8 - masterList.length);
     masterList.addAll(yelpList);
    //Get Yelp Pages
    masterList = List<LocationDoc>.from(masterList);
     return masterList.sublist(0, 8); 
   }

  //Randomly takes out restaurants so that the list includes at most maxAllowed items
  //NEEDS TO BE CHANGED
   static List<LocationDoc> trim(List<LocationDoc> list, int maxAllowed ){
     if(list.length <= maxAllowed) return list; 
     else {
       return list.sublist(0, maxAllowed );
     }
   
   }
}