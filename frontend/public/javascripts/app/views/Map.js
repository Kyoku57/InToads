define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
    'app/Stream'
], function($, _, Backbone, Bootstrap,stream){

    var MapView = Backbone.View.extend({

        el: $("#liveMap"),

        map: null,
        marker: null,

        events:{
        },

        initialize: function() {
            stream.registerOn("position", $.proxy(this.onNotification,this));
            var mapOptions = {
                center: new google.maps.LatLng(48.3474458,6.53568137),
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.HYBRID
            };
            this.map = new google.maps.Map(document.getElementById("liveMap"),mapOptions);
        },

        render: function(){

        },

        onNotification: function(notif){
            console.log("On notif in view : "+notif);
            var msg = notif.data;
            if(this.marker==null){
                var myLatlng = new google.maps.LatLng(msg.lat,msg.long);
                this.marker = new google.maps.Marker({
                    position: myLatlng,
                    map: this.map,
                    title:"Hello World!"
                });
            }
            else
               this.marker.setPosition(new google.maps.LatLng(msg.lat,msg.long));
        }

    });

    return MapView;


});
