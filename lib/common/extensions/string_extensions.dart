extension StringExtension on String{
  String getDateTime(){
    return this.isEmpty?'':this.substring(0,11);
  }
}