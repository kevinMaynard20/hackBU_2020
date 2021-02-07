import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/test.dart';
import 'LocationDoc.dart'; 



Future<List<LocationDoc>> getYelpPages(List<double> coords) async {
    var url = 'https://api.yelp.com/v3/businesses/search?';
    var auth = {
    'Authorization': 'Bearer AC541vgsaMmHds3GvBkjN6FIlteahWYRCqATKx01u6orAVYRYrUyg7zEjYrPAXQz_Xy4nE6BYhbE4y1liOHhmr6bk2kdxyqMxx9wgqlbxyEANedoSMx4Or9_ggkfYHYx'
    };


    var params = {
    'term': 'restaurants',
    'limit': '5',
    'latitude': coords[0].toString(),
    'longitude': coords[1].toString()
    };

    params.forEach((key, value) {
    url += '&' + key + '=' + value;
    });

    var response = await http.get(url, headers: auth);
    var body = json.decode(response.body);

    return formatYelpPages(body['businesses']);
   /* print('Response status: ${response.statusCode} \n \n');
    print(body['businesses']);*/

  }

  List<LocationDoc> formatYelpPages (List<dynamic> biz_names) {

    var YelpList = <LocationDoc>[];

    for (var i = 0; i < biz_names.length; i++) {
      var business = biz_names[i];
      var Name = business['name'];
      var Lat = business['coordinates']['latitude'];
      var Lon = business['coordinates']['longitude'];
      var address = business['location']['display_address'][0];
      var Image = business['image_url'];
      var URL = business['url'];

      var bizDoc = LocationDoc(Name, Lat, Lon, 'YelpPage');

      bizDoc.setURL(URL);
      bizDoc.setImageLink(Image);

      YelpList.add(bizDoc);
    };
    return YelpList;

  }
