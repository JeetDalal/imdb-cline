// To parse this JSON data, do
//
//     final covidApi = covidApiFromJson(jsonString);

import 'dart:convert';

CovidApi? covidApiFromJson(String str) => CovidApi.fromJson(json.decode(str));

String covidApiToJson(CovidApi? data) => json.encode(data!.toJson());

class CovidApi {
  CovidApi({
    this.covidApiGet,
    this.parameters,
    this.errors,
    this.results,
    this.response,
  });

  String? covidApiGet;
  Parameters? parameters;
  List<dynamic>? errors;
  int? results;
  List<Response?>? response;

  factory CovidApi.fromJson(Map<String, dynamic> json) => CovidApi(
        covidApiGet: json["get"],
        parameters: Parameters.fromJson(json["parameters"]),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
        results: json["results"],
        response: json["response"] == null
            ? []
            : List<Response?>.from(
                json["response"]!.map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "get": covidApiGet,
        "parameters": parameters!.toJson(),
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "results": results,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x!.toJson())),
      };
}

class Parameters {
  Parameters({
    this.country,
  });

  String? country;

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

class Response {
  Response({
    this.continent,
    this.country,
    this.population,
    this.cases,
    this.deaths,
    this.tests,
    this.day,
    this.time,
  });

  String? continent;
  String? country;
  int? population;
  Cases? cases;
  Deaths? deaths;
  Tests? tests;
  DateTime? day;
  DateTime? time;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        continent: json["continent"],
        country: json["country"],
        population: json["population"],
        cases: Cases.fromJson(json["cases"]),
        deaths: Deaths.fromJson(json["deaths"]),
        tests: Tests.fromJson(json["tests"]),
        day: DateTime.parse(json["day"]),
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "continent": continent,
        "country": country,
        "population": population,
        "cases": cases!.toJson(),
        "deaths": deaths!.toJson(),
        "tests": tests!.toJson(),
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "time": time?.toIso8601String(),
      };
}

class Cases {
  Cases({
    this.casesNew,
    this.active,
    this.critical,
    this.recovered,
    this.the1MPop,
    this.total,
  });

  dynamic casesNew;
  int? active;
  int? critical;
  int? recovered;
  String? the1MPop;
  int? total;

  factory Cases.fromJson(Map<String, dynamic> json) => Cases(
        casesNew: json["new"],
        active: json["active"],
        critical: json["critical"],
        recovered: json["recovered"],
        the1MPop: json["1M_pop"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "new": casesNew,
        "active": active,
        "critical": critical,
        "recovered": recovered,
        "1M_pop": the1MPop,
        "total": total,
      };
}

class Deaths {
  Deaths({
    this.deathsNew,
    this.the1MPop,
    this.total,
  });

  dynamic deathsNew;
  String? the1MPop;
  int? total;

  factory Deaths.fromJson(Map<String, dynamic> json) => Deaths(
        deathsNew: json["new"],
        the1MPop: json["1M_pop"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "new": deathsNew,
        "1M_pop": the1MPop,
        "total": total,
      };
}

class Tests {
  Tests({
    this.the1MPop,
    this.total,
  });

  String? the1MPop;
  int? total;

  factory Tests.fromJson(Map<String, dynamic> json) => Tests(
        the1MPop: json["1M_pop"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "1M_pop": the1MPop,
        "total": total,
      };
}
