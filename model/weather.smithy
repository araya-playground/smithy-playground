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

@readonly
operation GetCity {
   input := for City {
	@required
	$cityId
   } 

   output := for City {
	@required
	@notProperty
	name: String

	@required
	$coordinates
   }

   errors: [
	NoSuchResource
   ]
}

@readonly
operation GetForecast {
	input := for Forecast {
		@required
		$cityId
	}

	output ;= for Forecast {
		$chanceOfRain
	}
}

@error("client")
structure NoSuchResource {
	@required
	resourceType: String
}

