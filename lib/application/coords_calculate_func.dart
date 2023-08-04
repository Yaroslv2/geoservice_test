import 'dart:math';

Map<String, int> coordsCalculate(double lat, double long, int zoom) {
  const eccentricity = 0.0818191908426;

  var p = pow(2, zoom + 8) / 2;

  var beta = lat * pi / 180;
  var psi = (1 - eccentricity * sin(beta)) / (1 + eccentricity * sin(beta));
  var theta = tan(pi / 4 + beta / 2) * pow(psi, eccentricity / 2);
  var xCoord = p * (1 + long / 180);
  var yCoord = p * (1 - log(theta) / pi);

  return <String, int>{
    "x": (xCoord / 256.0).floor(),
    "y": (yCoord / 256.0).floor(),
    "z": zoom,
  };
}
