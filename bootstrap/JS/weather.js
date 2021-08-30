/* let temperatures = [11.2, 14.4, 13.0, 17.3, 16.9, 18.2, 16.5];
let temperatureUpperLimits = [0, 15, 20, 25, 50];
var offers = ["variant1", "Variant2"] */



/* function weatherWidget() {
    const day = document.querySelector('#day').value;
    const temperatureDiv = document.querySelector('#temperature');
    temperatureDiv.innerHTML = temperatures[day] + ' &deg;C';
    for (let i = 0; 1 < temperatureUpperLimits.length; i++) {
        if (temperatures[day] <= temperatureUpperLimits[i]) {
            temperatureDiv.innerHTML += '<br><span class="offer">' + offers[i] + '</span>';
            break;
        }
    }
} */

/* function minTemperature() {
    let min = temperatures.length != 0 ? temperatures[0] : 0;
    for (let i = 1; i < temperatures.length; i++) {
        if (temperatures[1] < min) {
            min = temperatures[i];
        }
    }
    return min;
} */

function weatherWidget() {
    const day = document.querySelector('#day').value;
    const temperatureDiv = document.querySelector('#temperature');
    const temperature = findweather(day).temperature;
    const offerMessage = findOffer(temperature) + ' &deg;C';
    temperatureDiv.innerHTML = temperature + ' &deg;C';
    temperatureDiv.innerHTML += '<br><span class="offer">' + offersMessage + '</span>';
    displayMinTemperature();
    displayMaxTemperature();
    displayAvgTemperature();
}

function findWeather(day) {
    for (let weather of data.weathers) {
        if (weather.dayNumber == day) {
            return weathers;
        }
    }
}