import 'dart:html';
import 'dart:convert';
import 'package:dialog/dialog.dart';
import 'package:http/http.dart' as http;

void main() {
  // var cities = [];
  // cities.add('Nova Friburgo');
  // cities.add('Planaltina');
  // cities.add('Londres');
  // cities.add('Iguatama');
  // cities.add('São Luís');
  // cities.add('Sorocaba');

  // loadData(cities);

  querySelector('#searchCity').onClick.listen((e) async {
    var myPrompt = await prompt('Qual cidade você quer buscar?');

    // Verificnado se o usuário digitou alguma coisa no prompt
    if (myPrompt.toString().length > 0)
      loadData([myPrompt.toString()]);
    else
      alert('Nenhuma codade digitada!');
  });
}

Future getWwather(String city) {
  String url =
      'https://api.hgbrasil.com/weather/?format=json-cors&locale=pt&city_name=$city&key=7d6c8b05';
  return http.get(url);
}

void loadData(List cities) {
  var empty = querySelector('#empty');

  if (empty != null) {
    empty.remove();
  }

  cities.forEach((city) {
    insertData(getWwather(city));
  });
}

void insertData(Future data) async {
  var insertData = await data;
  var body = json.decode(insertData.body);

  if (body['results']['forecast'].length > 0) {
    String html = '<div class="row">';
    html += formatedHtml(body['results']['city_name']);
    html += formatedHtml(body['results']['temp']);
    html += formatedHtml(body['results']['description']);
    html += formatedHtml(body['results']['wind_speedy']);
    html += formatedHtml(body['results']['sunrise']);
    html += formatedHtml(body['results']['sunset']);
    html += '</div>';

    querySelector('.table').innerHtml += html;
  }
}

String formatedHtml(var data) {
  return '<div class="cell">$data</div>';
}
