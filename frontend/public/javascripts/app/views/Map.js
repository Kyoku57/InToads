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
            stream.registerOn("newMessage", $.proxy(this.onNotification,this));
            var mapOptions = {
                center: new google.maps.LatLng(49.106664,6.081901),
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.HYBRID
            };
            this.map = new google.maps.Map(document.getElementById("liveMap"),mapOptions);
        },

        render: function(){

        },

        onNotification: function(notif){
            console.log("On notif in view : "+notif.message);
            if(this.marker==null){
                var myLatlng = new google.maps.LatLng(49.106664,6.081901);
                this.marker = new google.maps.Marker({
                    position: myLatlng,
                    map: this.map,
                    title:"Hello World!"
                });
            }
            else
               this.marker.setPosition(new google.maps.LatLng(49.105539,6.074409));
        }

    });

    return MapView;


});
