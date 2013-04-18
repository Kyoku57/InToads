package backend

import com.mongodb.DB
import com.mongodb.Mongo

class TeamsService {

    Mongo mongo

    def allTeams() {
        DB db = mongo.getDB("intoads")
        db.teams.find()
    }
}
