package backend

import grails.converters.JSON

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

        def coureur = riderService.findCoureur(id)

        render coureur as JSON
        return;
    }

    def riders(){

        def coureurs = riderService.findAllCoureurs()

        render coureurs as JSON
        return
    }
}
