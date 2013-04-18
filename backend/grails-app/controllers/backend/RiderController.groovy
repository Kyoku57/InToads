package backend

import grails.converters.JSON

class RiderController {

    /**
     * retourne le détail d'un coureur
     * @return
     */
    def index() {
        render("détail coureur")

        String id = params.id

        if (!id)
            return;

        def coureur = riderService.findCoureur(id)

        render coureur as JSON
        return;
    }
}
