require.config({

    baseUrl: "/assets/javascripts",

    shim: {
        "bootstrap": {
            deps: ["jquery"]
        }
    },

    paths: {
        jquery:                 'vendor/jquery-1.9.1.min',
        backbone:               'vendor/backbone-min',
        underscore:             'vendor/underscore-min',
        text:                   'vendor/require-text',
        bootstrap:              'vendor/bootstrap.min'
    }
});

require([
    'app/views/Map'
], function (Map) {
    // Application startup
    var mapView=new Map();
    var source = new EventSource("/live");
    source.onmessage = $.proxy(mapView.onNotification,mapView);
    console.log("Application loaded.")
});