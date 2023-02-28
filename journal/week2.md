# Week 2 — Distributed Tracing

## Week 2 Todo Tasks  
- [ ] [Watch Week 2 Live-Stream Video](https://www.youtube.com/watch?v=2GD9xCzRId4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=30)
- [ ] [Watch Chirag Week 2 - Spending Considerations (Coming Soon)]()
- [X] [Watched Ashish's Week 2 - Observability Security Considerations](https://www.youtube.com/watch?v=bOf4ITxAcXc&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=31)
- [X] [Instrument Honeycomb with OTEL](https://www.youtube.com/watch?v=2GD9xCzRId4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=30)
- [ ] [Instrument AWS X-Ray](https://www.youtube.com/watch?v=n2DTsuBrD_A&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=32)
- [ ] [Configure custom logger to send to CloudWatch Logs](https://www.youtube.com/watch?v=ipdFizZjOF4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=33)
- [ ] [Integrate Rollbar and capture and error](https://www.youtube.com/watch?v=xMBDAb5SEU4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=35)


## Technical Tasks 
Honeycomb.io
- [X] Instrument our backend flask application to use Open Telemetry (OTEL) with Honeycomb.io as the provider
- [X] Run queries to explore traces within Honeycomb.io

AWS X-Ray
- [ ] Instrument AWS X-Ray into backend flask application
- [ ] Configure and provision X-Ray daemon within docker-compose and send data back to X-Ray API
- [ ] Observe X-Ray traces within the AWS Console

Rollbar
- [ ] Integrate Rollbar for Error Logging
- [ ] Trigger an error an observe an error with Rollbar

WatchTower
- [ ] Install WatchTower and write a custom logger to send application log data to CloudWatch Log group




### Honeycomb.io
#### Instrument our backend flask application to use Open Telemetry (OTEL) with Honeycomb.io as the provider

Add python dependencies into our `requirements.txt` file and install them
```
flask 
flask-cors

opentelemetry-api 
opentelemetry-sdk 
opentelemetry-exporter-otlp-proto-http
opentelemetry-instrumentation-flask 
opentelemetry-instrumentation-requests
```

Install Dependencies 
```sh
pip3 install -r requirements.txt
```

Set up environment `OTEL_` (OpenTelemetry) variables in our `docker-compose.yml` file 
```sh
version: "3.8"
services:
  backend-flask:
    environment:
      FRONTEND_URL: "https://3000-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
      BACKEND_URL: "https://4567-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
      # OpenTelemetry environment variables 
      # This is what determines the service name in the spans that get sent to your application. 
      OTEL_SERVICE_NAME: "backend-flask"       
      # this is the honeycomb endpoint used to send data
      OTEL_EXPORTER_OTLP_ENDPOINT: "https://api.honeycomb.io"
      # this variable is used to set additional headers in the OTLP requests sent by the exporter. 
      # This can be useful in cases where the backend system requires additional authentication, 
      # authorization or metadata information to be sent in the headers.
      OTEL_EXPORTER_OTLP_HEADERS: "x-honeycomb-team=${HONEYCOMB_API_KEY}" 
...
```

Add instrumentation code to our backend 
```python
# Honeycomb.io
from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.trace.export import ConsoleSpanExporter, SimpleSpanProcessor

# Honeycomb.io 
# Initialize tracing and an exporter that can send data to Honeycomb
provider = TracerProvider()
processor = BatchSpanProcessor(OTLPSpanExporter())
provider.add_span_processor(processor)

# Show this in the logs within the backend-flask app (STDOUT)
simple_processor = SimpleSpanProcessor(ConsoleSpanExporter())
provider.add_span_processor(simple_processor)

trace.set_tracer_provider(provider)
tracer = trace.get_tracer(__name__)

app = Flask(__name__)

# Honeycomb.io 
# Initialize automatic instrumentation with Flask
FlaskInstrumentor().instrument_app(app)
RequestsInstrumentor().instrument()
```

Create Honeycomb environment
![Create honeycomb environment](./assets/week-02/created-honeycomb.io-environment.png)

Create span exporter to log on STDOUT
![Create span exporter to log on STDOUT](./assets/week-02/add-console-span-exporter-STOUT.png)


#### Run queries to explore traces within Honeycomb.io
Query new data and show on Honeycomb dashboard
![Query new data and show on Honeycomb dashboard](./assets/week-02/new-query-raw-data.png)






---

#### Homework Challenges
- [ ] Instrument Honeycomb for the frontend-application to observe network latency between frontend and backend [HARD]
- [ ] Add custom instrumentation to Honeycomb to add more attributes eg. `UserId`, Add a `custom span`
- [ ] Run custom queries in Honeycomb and save them later eg. Latency by `UserID`, Add `Recent Traces`

### Instrument Honeycomb for the frontend-application to observe network latency between frontend and backend [HARD]
### Add custom instrumentation to Honeycomb to add more attributes eg. `UserId`, Add a `custom span`
### Run custom queries in Honeycomb and save them later eg. Latency by `UserID`, Add `Recent Traces`