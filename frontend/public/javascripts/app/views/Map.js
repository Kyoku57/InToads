define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
    'app/Stream'
], function($, _, Backbone, Bootstrap,stream){


    var visage_papal = '/assets/images/pope_marker.png';
    var walker_rider = '/assets/images/wtr_marker.png';
    var nico_unchained = '/assets/images/unchained_marker.png';
    
    var MapView = Backbone.View.extend({

        el: $("#liveMap"),
        
        map: null,
        marker: null,
        walker_marker: null,
        papal_marker: null,
        unchained_marker: null,

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
            
            if(notif.rider.teamId == 'team1'){
	            if(this.papal_marker==null){
	                var myLatlng = new google.maps.LatLng(msg.lat,msg.long);
	                this.papal_marker = new google.maps.Marker({
	                    position: myLatlng,
	                    map: this.map,
	                    title:"Visage Papal",
	                    icon: visage_papal
	                });
	            }
	            else
	               this.papal_marker.setPosition(new google.maps.LatLng(msg.lat,msg.long));
	            
            }else  if(notif.rider.teamId == 'team2'){
	            if(this.walker_marker==null){
	                var myLatlng = new google.maps.LatLng(msg.lat,msg.long);
	                this.walker_marker = new google.maps.Marker({
	                    position: myLatlng,
	                    map: this.map,
	                    title:"Walker Texas Rider",
	                    icon: walker_rider
	                });
	            }
	            else
	               this.walker_rider.setPosition(new google.maps.LatLng(msg.lat,msg.long));
	            
            }else  if(notif.rider.teamId == 'team1'){
	            if(this.unchained_marker==null){
	                var myLatlng = new google.maps.LatLng(msg.lat,msg.long);
	                this.unchained_marker = new google.maps.Marker({
	                    position: myLatlng,
	                    map: this.map,
	                    title:"Nico Unchained",
	                    icon: nico_unchained
	                });
	            }
	            else
	               this.unchained_marker.setPosition(new google.maps.LatLng(msg.lat,msg.long));
	            
            }else {
	            if(this.marker==null){
	                var myLatlng = new google.maps.LatLng(msg.lat,msg.long);
	                this.marker = new google.maps.Marker({
	                    position: myLatlng,
	                    map: this.map,
	                    title:"Unknow Team"
	                });
	            }
	            else
	               this.marker.setPosition(new google.maps.LatLng(msg.lat,msg.long));
            }
        }

    });

    return MapView;


});
