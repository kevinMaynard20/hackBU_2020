class LocationDoc {
  String PageType;
  String Name; 
  String Descript;
  String ImageLink; 
  String Type; 
  String URL; 
  double Lat;
  double Lon;

  LocationDoc(Name, Lat, Lon, PageType){
    this.Name = Name;
    this.Lat = Lat;
    this.Lon = Lon; 
    this.PageType = PageType; 
  }

  //Setter Methods
  void setDescript(String Descript){
    this.Descript = Descript ; 
  }

  void setURL(String URL){
    this.URL = URL;
  }

  void setImageLink(String link){
    ImageLink = link; 
  }

//Getter methods
  String getType(){
    return PageType; 
  }

  String getName(){
    return Name;
  }

  String getDescript(){
    return Descript; 
  }

  String getImageLink(){
    return ImageLink; 
  }

  String getURL(){
    return URL;
  }

  double getLat(){
    return Lat; 
  }

  double getLon(){
    return Lon; 
  }

  @override
  String toString(){
    return 'Name : $Name \n Description : $Descript \n Coords: $Lat , $Lon \n URL : $URL';
  }


}
