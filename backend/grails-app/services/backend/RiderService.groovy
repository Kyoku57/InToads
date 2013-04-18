package backend

class RiderService {


    def mongo

    /**
     * recupere un coureur à partir de son id
     */
    def findCoureur(String idCoureur) {

        // Get a DB
        def db = mongo.getDB("intoads")

        def values = db.riders.find([id:idCoureur]).collect{it-> ["id":it.id,"name":it.name,"twitter":it.twitter]}

        return values[0];
    }

    def findAllCoureurs()
    {
        def db = mongo.getDB("intoads")

        def values = db.riders.find().collect{ it->
            it.id + " at " + it.name+" "+it.twitter
        }

        return values;
    }
}
