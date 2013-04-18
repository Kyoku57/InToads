define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
    'app/Stream',
    'moment',
], function($, _, Backbone, Bootstrap,stream){

    var LogEvents = Backbone.View.extend({

        el1: $("#log_team1"),
        el2: $("#log_team2"),
        el3: $("#log_team3"),

        initialize: function() {
            stream.registerAll($.proxy(this.onNotification,this));
        },

        render: function(){

        },

        onNotification: function(notif){
        	
        	var message = "<span>" ;
        	message += "Coureur ";
        	message += "<b>" + notif.rider.name + "</b>";
        	message += " last update => ";
        	message += moment.unix(notif.data.time).format('DD/MM/YYYY hh:mm:ss');
        	message += "</span>";
            
        	if(notif.rider.teamId == 'team1'){
            	this.el1.html(message);
            }else if(notif.rider.teamId == 'team2'){
            	this.el2.html(message);
            }else if(notif.rider.teamId == 'team3'){
            	this.el3.html(message);
            }
        }

    });

    return LogEvents;


});
