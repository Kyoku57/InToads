package backend



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(TeamsService)
class TeamsServiceTests {

    void allTeams() {
        TeamsService teamsService
        def teams = teamsService.allTeams()
    }
}
