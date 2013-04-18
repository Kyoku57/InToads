package backend

import grails.converters.JSON
import objects.Rider

class RiderController {


    RiderService riderService;


    /**
     * retourne le détail d'un coureur
     * @return
     */
    def index() {

        String id = params.id

        if (!id)
            return;

        Rider coureur = riderService.findCoureur(id)

        def JSONFormat = [id:coureur.id, name:coureur.name, twitter:coureur.twitter]

        render JSONFormat as JSON

        return;
    }

    def riders(){

        def coureurs = riderService.findAllCoureurs()

        render coureurs as JSON
        return
    }
}
