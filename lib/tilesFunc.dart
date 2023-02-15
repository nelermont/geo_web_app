import 'dart:math';

class MathGeo {
  var long = 55.682640;
  var lat = 37.633311;
  var eccentricity = 0.0818191908426;
  var zoom = 19;

  tilesXY(lat, long, z) {
    var rho = pow(2, z + 8) / 2;
    var beta = lat * pi / 180;
    var phi = (1 - eccentricity * sin(beta)) / (1 + eccentricity * sin(beta));
    var theta = tan(pi / 4 + beta / 2) * pow(phi, eccentricity / 2);

    var xP = ((rho * (1 + long / 180)) / 256).floor();
    var yP = ((rho * (1 - log(theta) / pi)) / 256).floor();

    var linkImg =
        "https://core-renderer-tiles.maps.yandex.net/tiles?l=map&v=23.02.12-0-b230203083000&x=${xP}&y=${yP}&z=${z}&scale=1&lang=ru_RU&ads=enabled";

    return linkImg;
  }
}
