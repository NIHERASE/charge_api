# ChargeApi

## Try it out

```bash
git clone git@github.com:NIHERASE/time_distance_api.git
git clone git@github.com:NIHERASE/charge_api.git

# You might need to set your api keys in ./time_distance_api/config/config.exs
# ChargeApi will be exposed on port 4001 and TimeDistanceApi on 4000.
cd charge_api
docker-compose up
```

Test links for a route: [ChargeApi](http://localhost:4001/api/v1/get_charge?origin_lat=55.776451&origin_lon=37.655212&dest_lat=55.757399&dest_lon=37.660853),
[TimeDistanceApi](http://localhost:4000/api/v1/get_time_distance?origin_lat=55.776451&origin_lon=37.655212&dest_lat=55.757399&dest_lon=37.660853)
and here is this [route](https://www.google.ru/maps/dir/'55.776451,37.655212'/'55.757399,37.660853'/@55.7619876,37.6429937,14z/data=!3m1!4b1!4m9!4m8!1m3!2m2!1d37.655212!2d55.776451!1m3!2m2!1d37.660853!2d55.757399?hl=en) on Google.
