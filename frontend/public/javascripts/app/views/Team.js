/**
 * Created with IntelliJ IDEA.
 * User: camille
 * Date: 18/04/13
 * Time: 21:22
 * To change this template use File | Settings | File Templates.
 */
define([
    'jquery',
    'underscore',
    'backbone',
    'bootstrap',
    'app/Stream'
], function($, _, Backbone, Bootstrap,stream){

    var Team = Backbone.View.extend({

        el: $("#team"),


        initialize: function() {
            //stream.registerAll($.proxy(this.onNotification,this));
        },

        render: function(){

        },

        onNotification: function(notif){
            //this.$el.prepend("<li>"+JSON.stringify(notif)+"</li>");
        }

    });

    return Team;


});
