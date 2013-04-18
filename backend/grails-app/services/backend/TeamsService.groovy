package backend

import com.mongodb.Mongo
import org.bson.types.ObjectId

class TeamsService {

    def mongo

    def allTeams() {
        def values = Teams.findAll()
    }
}
