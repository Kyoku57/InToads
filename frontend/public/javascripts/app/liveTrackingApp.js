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
    'app/Stream',
    'app/views/Map',
    'app/views/LogEvents'
], function (stream,Map,LogEvents) {
    // Application startup
    var mapView=new Map();
    var logView=new LogEvents();
    var source = new EventSource("/live");
    source.onmessage = $.proxy(stream.trigger,stream);
    console.log("Application loaded.")
});