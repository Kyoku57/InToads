package backend

import org.bson.types.ObjectId

class Teams {

    String name

    static mapping = {
        collection "teams"
        database "intoads"
        name field:"name"
    }

}
