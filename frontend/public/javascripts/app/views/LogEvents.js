define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
    'app/Stream'
], function($, _, Backbone, Bootstrap,stream){

    var LogEvents = Backbone.View.extend({

        el: $("#log"),


        initialize: function() {
            stream.registerAll($.proxy(this.onNotification,this));
        },

        render: function(){

        },

        onNotification: function(notif){
            this.$el.prepend("<li>"+JSON.stringify(notif)+"</li>");
        }

    });

    return LogEvents;


});
