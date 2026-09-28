class FlagAssets {
  static const String _png = "assets/flags";

  // Afrique
  static const String tg = "$_png/tg.png"; // TOGO
  static const String bj = "$_png/bj.png"; // BENIN
  static const String gh = "$_png/gh.png"; // GHANA
  static const String ci = "$_png/ci.png"; // COTE D'IVOIRE
  static const String ne = "$_png/ne.png"; // NIGER
  static const String gn = "$_png/gn.png"; // GUINEE
  static const String ml = "$_png/ml.png"; // MALI
  static const String ng = "$_png/ng.png"; // NIGERIA
  static const String za = "$_png/za.png"; // AFRIQUE DU SUD
  static const String ke = "$_png/ke.png"; // KENYA
  static const String bf = "$_png/bf.png"; // BURKINA FASO
  static const String sn = "$_png/sn.png"; // SENEGAL

  // Europe
  static const String fr = "$_png/fr.png"; // FRANCE
  static const String lu = "$_png/lu.png"; // LUXEMBOURG
  static const String de = "$_png/de.png"; // GERMANY
  static const String gb = "$_png/gb.png"; // UNITED KINGDOM

  // Amérique
  static const String us = "$_png/us.png"; // UNITED STATES


static url(String code){
  return "$_png/${code.toLowerCase()}.png";
}
}
