console.log('Hello from the JavaScript console!');

// Your AJAX request here
$.ajax({
  type: 'GET',
  url:
    'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=9c6b279f1c36ece02e7dcff91eb6f67c',
  success(data) {
    console.log('We have your weather!');
    console.log(data);
  },
  error() {
    console.log('An error occurred.');
  }
});

// Add another console log here, outside your AJAX request
console.log('Finished the Ajax requesting process');

/*

###The Order that the console.log's run:

Hello from the JavaScript console!
Finished the Ajax requesting process
We have your weather!

|> Object {coord: Object, weather: Array(1), base: "stations", main: Object, visibility: 16093…}

--------------- Questions ---------------
1.  When does the request get sent?
- Send the request after the page has loaded.
- It makes the HTTP request in the background.

2.  When does the response come back?
- The response comes back after the ajax request is completed.
- The browser will not load a new page, it will stay on the same page
- On the HTTP response, the browswer will fire a javaScript callback function

3.  What's the current weather in New York?
- Request:
  -'http://api.openweathermap.org/data/2.5/weather?q=Newyork,us&appid=9c6b279f1c36ece02e7dcff91eb6f67c'

  - Humidity: 64 %
  - pressure: 1012 hPa
  - temp: 294.06 Kevin
  - temp_max: 295.15 Kevin
  - temp_min: 292.15 Kevin

4.  Did the page refresh?
- No

5.  How could we use different HTTP methods in our request?

- $.ajax (low-level, complete interface)
- $.get ("more convenient" function for GET requests)
- $.post ("more convenient" function for POST requests)

- The two commonly used methods for ajax request between a client and server are: GET and POST
  - GET is basically used for just getting (retrieving) some data from server.
  Note: the GET method may return cached data.
  - POST can also be used to get some data from the server. However, the POST method NEVER caches data, and is often used to send data along with the request.

*/
