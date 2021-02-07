import 'WikiAPI.dart';
import 'LocationDoc.dart';


class APIHandler {

   static Future<List<LocationDoc>> getLocationInfo(coords) async {
     var masterList = [];
     
     //Get wikipedia pages
     var wikiList = await getWikiPages(coords);
     wikiList = Trim(wikiList, 3);
     masterList.addAll(wikiList);

    //Get Yelp Pages
    masterList = List<LocationDoc>.from(masterList);
     return masterList ; 
   }

  //Randomly takes out restaurants so that the list includes at most maxAllowed items
  //NEEDS TO BE CHANGED
   static List<LocationDoc> Trim(List<LocationDoc> list, int maxAllowed ){
     //CHANGE THIS
     return list; 
   }
}