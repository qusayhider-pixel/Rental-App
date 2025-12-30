import 'city_model.dart';

class Province {
  final String name;
  final List<City> cities;

  Province({
    required this.name,
    required this.cities,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      name: json['name'],
      cities: (json['cities'] as List)
          .map((city) => City.fromJson(city))
          .toList(),
    );
  }
}


// ---------------------------------------------------------------------------
// Static Provinces Data
// ---------------------------------------------------------------------------

final List<Province> provinces = [
  Province(name: 'Damascus', cities: [
      City( name: 'Dummar'),
      City( name: 'Al-Shagour'),
      City( name: 'Mazzeh'),
      City( name: 'Qanawat'),
      City( name: 'Barzeh'),
    ],),
  Province(name: 'Rif Dimashq', cities: [
      City( name: 'Douma'),
      City( name: 'Darayya'),
      City( name: 'Qudsaya'),
      City( name: 'Al-Tall'),
      City( name: 'Zabadani'),
      City( name: 'Yabroud'),
      City( name: 'Qatana'),
    ],),
  Province(name: 'Aleppo', cities: [
      City( name: 'Azaz'),
      City( name: 'Al-Bab'),
      City( name: 'Manbij'),
      City( name: 'Jarabulus'),
    ],),
  Province(name: 'Homs', cities: [
      City( name: 'Tadmur'),
      City( name: 'Al-Qusayr'),
      City( name: 'Al-Rastan'),
      City( name: 'Talbiseh'),
    ],),
  Province(name: 'Hama', cities: [
      City( name: 'Salamiyah'),
      City( name: 'Masyaf'),
      City( name: 'Kafr Zita'),
    ],),
  Province(name: 'Idlib', cities: [
      City( name: 'Maarrat al-Numan'),
      City( name: 'Ariha'),
      City( name: 'Saraqib'),
      City( name: 'Jisr al-Shughur'),
    ],),
  Province(name: 'Latakia', cities: [
      City( name: 'Jableh'),
      City( name: 'Al-Qardaha'),
      City( name: 'Al-Haffah'),
      City( name: 'Al-sheik Daher'),
    ],),
  Province(name: 'Tartus', cities: [
      City( name: 'Baniyas'),
      City( name: 'Safita'),
      City( name: 'Duraykish'),
      City( name: 'Bosaira'),
    ],),
  Province(name: 'Al-Hasakah', cities: [
      City( name: 'Qamishli'),
      City( name: 'Ras al-Ayn'),
      City( name: 'Al-Malikiyah'),
    ],),
  Province(name: 'Al-Raqqa', cities: [
      City( name: 'Tabqa'),
      City( name: 'Tell Abyad'),
    ],),
  Province(name: 'Deir ez-Zor', cities: [
      City( name: 'Al-Mayadin'),
      City( name: 'Al-Bukamal'),
    ],),
  Province(name: 'Daraa', cities: [
      City( name: 'Nawa'),
      City( name: 'Jasim'),
      City( name: 'Tafas'),
    ],),
  Province(name: 'As-Suwayda', cities: [
      City( name: 'Shahba'),
      City( name: 'Salkhad'),
    ],),
  Province(name: 'As-Quneitra', cities: [
      City( name: 'Quneitra'),
      City( name: 'Khan Arnabah'),
    ],),


];