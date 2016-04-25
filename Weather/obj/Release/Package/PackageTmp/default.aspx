<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Weather._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>myWeather</title>
    <link href="css/style.css" rel="stylesheet" />
    <link href="weather/weather.css" rel="stylesheet" />
    <link href='https://fonts.googleapis.com/css?family=Dosis' rel='stylesheet' type='text/css' />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="weather/jquery-simpleWeather.min.js"></script>

    <script type="text/javascript">
        /* Does your browser support geolocation? */
        /*
        if ("geolocation" in navigator) {
            $('.js-geolocation').show();
        } else {
            $('.js-geolocation').hide();
        }
        */
        /* Where in the world are you? */
        /*
        $('.js-geolocation').on('click', function () {
            navigator.geolocation.getCurrentPosition(function (position) {
                loadWeather(position.coords.latitude + ',' + position.coords.longitude); //load weather using your lat/lng coordinates
            });
        });
        */
        
        $(document).ready(function () {
            startTime();
            navigator.geolocation.getCurrentPosition(function (position) {
                loadWeather(position.coords.latitude + ',' + position.coords.longitude); //load weather using your lat/lng coordinates
            });
            setInterval(loadWeatherAgain, 300000);
        });

        function loadWeatherAgain() {
            navigator.geolocation.getCurrentPosition(function (position) {
                loadWeather(position.coords.latitude + ',' + position.coords.longitude); //load weather using your lat/lng coordinates
            });
        }
        function loadWeather(location, woeid) {
            $.simpleWeather({
                location: location,
                woeid: woeid,
                unit: 'c',
                speed: 'km',
                success: function (weather) {
                    //html = '<h2><i class="icon-' + weather.code + '"></i> ' + weather.temp + '&deg;' + weather.units.temp +
                    //    '&nbsp;&nbsp;&nbsp;&nbsp;Wind Chill:' + weather.wind.chill + '</h2>';
                    windChill = weather.wind.chill;
                    windChillCelsius = Math.round((5.0 / 9.0) * (windChill - 32.0));

                    weatherNow = '<i class="icon-' + weather.code + '"></i> &nbsp;' + weather.temp + '&deg;' + weather.units.temp +
                            '<label class="windchill">Feels Like ' + windChillCelsius + '</label>';

                    weatherHighlow = "High " + weather.high + " &nbsp;&nbsp; Low " + weather.low;
                    weatherCity = weather.city + ", " + weather.region;
                    weatherCurrently = weather.currently;
                    weatherWind = weather.wind.direction + " " + weather.wind.speed + " " + weather.units.speed;
                    weatherSunrise = "Sunrise " + weather.sunrise;
                    weatherSunset = "Sunset " + weather.sunset;
                    weatherForecastDayOne = '<p><label class="high">' + weather.forecast[1].high + '</label> &nbsp; <label class="low">'
                                        + weather.forecast[1].low + '</label></p><p>' +
                                        '<i class="icon-' + weather.forecast[1].code + '"></i></p><p>' +
                                        weather.forecast[1].day + '</p>';
                    weatherForecastDayTwo = '<p><label class="high">' + weather.forecast[2].high + '</label> &nbsp; <label class="low">'
                                        + weather.forecast[2].low + '</label></p><p>' +
                                        '<i class="icon-' + weather.forecast[2].code + '"></i></p><p>' +
                                        weather.forecast[2].day + '</p>';
                    weatherForecastDayThree = '<p><label class="high">' + weather.forecast[3].high + '</label> &nbsp; <label class="low">'
                                        + weather.forecast[3].low + '</label></p><p>' +
                                        '<i class="icon-' + weather.forecast[3].code + '"></i></p><p>' +
                                        weather.forecast[3].day + '</p>';
                    weatherForecastDayFour = '<p><label class="high">' + weather.forecast[4].high + '</label> &nbsp; <label class="low">'
                                        + weather.forecast[4].low + '</label></p><p>' +
                                        '<i class="icon-' + weather.forecast[4].code + '"></i></p><p>' +
                                        weather.forecast[4].day + '</p>';
                    weatherLastUpdated = weather.updated;

                    $("#now").html(weatherNow);
                    $("#highlow").html(weatherHighlow);
                    $("#city").html(weatherCity);
                    $("#currently").html(weatherCurrently);
                    $("#wind").html(weatherWind);
                    $("#sunrise").html(weatherSunrise);
                    $("#sunset").html(weatherSunset);
                    $("#dayone").html(weatherForecastDayOne);
                    $("#daytwo").html(weatherForecastDayTwo);
                    $("#daythree").html(weatherForecastDayThree);
                    $("#dayfour").html(weatherForecastDayFour);
                    $('#lastupdated').html(weatherLastUpdated);
                },
                error: function (error) {
                    $("#now").html('<p>' + error + '</p>');
                }
            });
        }
        
        function startTime() {
            var d = new Date();
            var h = d.getHours();
            var m = d.getMinutes();
            var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            var dayName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            m = checkTime(m);
            document.getElementById('clock').innerHTML = h + ":" + m;
            document.getElementById('mDay').innerHTML = dayName[d.getDay()];
            document.getElementById('mDate').innerHTML = monthNames[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
            var t = setTimeout(function () { startTime() }, 500);
        }

        function checkTime(i) {
            if (i < 10) { i = "0" + i };  // add zero in front of numbers < 10
            return i;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <!--<div style="text-align:center; font-size:18px; margin-bottom:20px;"><p>Weather data source: Yahoo! &nbsp;&nbsp; jQuery plugin by: <a href="http://simpleweatherjs.com/" target="_blank">http://simpleweatherjs.com/</a></p>
                <p>Weather Data Last Updaed: <label id="lastupdated"></label></p>
            </div>-->
            <div class="datetime">
                <p>
                    <label id="mDay"></label>
                    <label id="mDate"></label>
                    <label id="clock"></label>
                </p>
            </div>

            <div id="now"></div>

            <div id="highlow"></div>
            
            <div id="currentwrapper">
                <!--<div id="refresh"><asp:ImageButton ID="img_button" runat="server" 
                    ImageUrl="images/noun_31170_cc.svg" alt="refresh" OnClick="img_button_Click" ToolTip="Refresh" 
                    CssClass="refreshbutton" /></div>-->
                <ul id="current">
                    <li id="city"></li>
                    <li id="currently"></li>
                    <li id="wind"></li>
                </ul>
            </div>

            <div id="sunwrapper">
                <ul id="sun">
                    <li id="sunrise"></li>
                    <li id="sunset"></li>
                </ul>
            </div>

            <div id="forecastwrapper">
                <ul id="forecast">
                    <li id="dayone"></li>
                    <li id="daytwo"></li>
                    <li id="daythree"></li>
                    <li id="dayfour"></li>
                </ul>
            </div>
        </div>
    </form>
</body>
</html>
