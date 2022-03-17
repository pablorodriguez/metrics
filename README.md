
# METRICS API

Build a metric logging and reporting service that sums metrics by time window for the most
recent hour. You will build a lightweight web server that implements the two main APIs
defined below.

### API
###### POST metric
Create new metric with value
```json
POST /metric/{key}
    {
    "value": 30
    }
```
```
curl --location --request POST 'http://localhost:3000/metric/visitor' --form 'value="10.2"'
```

##### GET metric
Return the sum of all metrics reportes for this key over the last past hour
```json
GET /metric/{key}/sum
Response 200
{
	"value": 400
}

```
```
curl --location --request GET 'http://localhost:3000/metric/visitor/sum'
```

### Ruby version
* 2.6.6

### How to run the test suite
`bundle exec rspec`

