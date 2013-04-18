package backend

import grails.converters.JSON


class TeamsController {

    def mongo

    def index() {

        def listeams = Teams.findAllByName("test")

        render listeams as JSON
    }
}
