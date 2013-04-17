define([
    'backbone',
    'underscore'
], function(Backbone,_){

    var Stream = {

        listeners: new Array(),
        allListeners: new Array(),

        registerOn: function(eventType,handler){
            if(this.listeners[eventType]==null)
                this.listeners[eventType]=new Array();

            this.listeners[eventType].push(handler);
        },

        registerAll: function(handler){
            this.allListeners.push(handler);
        },

        trigger: function(event){
            var jsonEvt = JSON.parse(event.data);
            if(this.listeners[jsonEvt.type]!=null){
                _.each(this.listeners[jsonEvt.type], function(handler){
                    handler(jsonEvt);
                });
            }
            _.each(this.allListeners,function(handler){
                handler(jsonEvt);
            })
        }

    };

    return Stream;

});