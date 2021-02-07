import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/test.dart';
import 'LocationDoc.dart'; 


//Methods that handle all wiki api calls


//Asynchronous method that returns a FUTURE containing a list of LocationDocs based on the wikipedia pages
Future<List<Object>> getWikiPages(List<double> coords) async {
    var cordsString = coords[0].toString() + '|' + coords[1].toString();  //Getting right coords format
    var url = 'https://en.wikipedia.org/w/api.php?'; //API Endpoint
    var params = {    
      'action': 'query',
      'prop' :'description|coordinates|pageimages',
      'format': 'json',
      'generator': 'geosearch',
      'ggscoord': cordsString ,
      'ggslimit': '10',
      'ggsradius': '10000',
      
      }; 

    
    //Dynamically constructing our URL
    params.forEach((key, value) => 
      url += '&' + key + '=' + value
    );

    print(url + '\n \n');
    
    //Getting response and turning it into an object
    var response = await http.get(url); 
    var body = json.decode(response.body);

    //Getting the list of wikipedia page objects
    var pages = body['query']['pages'];

    //Formating wiki page objects into correct format and returning them
    return formatWikiPages(pages);
  }


//Takes the pages object wikipedia returns and converts it into a list of classes that we need
List<Object> formatWikiPages(Map pages){
    var LocationDocList = <Object>[]; 
    pages.forEach( (pageId, pageBody){
      var Name = pageBody['title'];
      var Description = pageBody['description'];
      var Lat = pageBody['coordinates'][0]['lat'];
      var Lon = pageBody['coordinates'][0]['lon'];
      var PageTitle = Name.replaceAll(' ', '_');
      var URL = 'https://en.wikipedia.org/wiki/' + PageTitle ;
      var page =  LocationDoc(Name,  Lat, Lon , 'WikiPage');
      page.setURL(URL);
      page.setDescript(Description);
      LocationDocList.add(page);

      
    });
    return LocationDocList ; 
  }

