server.log("Read the Weather Value with: " + http.agenturl() + "?weather");

local weather;
local dataNull;
local jsonReturn;

function requestHandler(request, response) {
  try {
    // check if the user sent led as a query parameter
    if ("weather" in request.query) {
      
        device.send("getWeather", dataNull);
        server.log("Asking for the weather");
        device.on("sendWeather", function(myWeather){
                
                weather = myWeather;
                jsonReturn = http.jsonencode(weather);
                    // send a response back saying everything was OK.
                 server.log(jsonReturn);
                response.send(200, jsonReturn);
        });
    }
  } catch (ex) {
    response.send(500, "Internal Server Error: " + ex);
  }
  
}

function setWeather(myWeather){

    weather = myWeather;
    jsonReturn = http.jsonencode(weather);

}

//device.on("sendWeather", setWeather);

// register the HTTP handler
http.onrequest(requestHandler);