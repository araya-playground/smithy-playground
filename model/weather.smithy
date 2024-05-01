$version: "2"
namespace: example.weather

service Weather {
    version: "2024-05-01"
    resources: [
	City
    ]
}

resource City {
    identifiers: { cityId: CityId }
    properties: { coordinates: CityCoordinates }
    read: GetCity
    list: ListCities
    resouces: [
	Forecast
    ]
}

structure CityCoordinates {
	@required
	latitude: Float

	@required
	longitude: Float
}

structure GetCityOutput for City {
	$coordinates
}

resource Forecast {
	identifiers: {cityId: CityId}
	properties: {chanceOfRain: Float}
	read: GetForecast
}

structure GetForecastOutput for Forecast {
	$chanceOfRain
}

@pattern ("^[A-Za-z0-9 ]+$")
string CityId