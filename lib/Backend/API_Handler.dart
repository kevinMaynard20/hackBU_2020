import 'WikiAPI.dart';


class APIHandler {
   static Future<List<Object>> getLocationInfo(coords) async {
     var masterList = [];
     
     //Get wikipedia pages
     var wikiList = await getWikiPages(coords);
     wikiList = Trim(wikiList, 3);
     masterList.addAll(wikiList);

    //Get Yelp Pages

     return masterList ; 
   }

  //Randomly takes out restaurants so that the list includes at most maxAllowed items
  //NEEDS TO BE CHANGED
   static List<Object> Trim(List<Object> list, int maxAllowed ){
     //CHANGE THIS
     return list; 
   }
}