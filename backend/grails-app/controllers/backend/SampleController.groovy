package backend

import grails.converters.JSON

class SampleController {

    /**
     * To test this controller, simply run "grails run-app" and go to http://localhost:8080/backend/sample !
     */

    def mongo

    def sampleMongo() {
        // Get a DB
        def db = mongo.getDB("intoads")
        // Insert a sample document
        db.samples.insert(
            [
               name: "Test",
               date: new Date()
            ]
        )
        // Get all documents, and build a collection of string
        def values = db.samples.find().collect{ it->
            it.name + " at " + it.date
        }
        // Create JSON result
        def result = [
            success: true,
            message: "OK!",
            names: values
        ]
        // And rendering!
        render result as JSON
    }
}
