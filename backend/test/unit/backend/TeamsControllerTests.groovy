package backend



import org.junit.*
import grails.test.mixin.*

@TestFor(TeamsController)
@Mock(Teams)
class TeamsControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/teams/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.teamsInstanceList.size() == 0
        assert model.teamsInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.teamsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.teamsInstance != null
        assert view == '/teams/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/teams/show/1'
        assert controller.flash.message != null
        assert Teams.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/teams/list'

        populateValidParams(params)
        def teams = new Teams(params)

        assert teams.save() != null

        params.id = teams.id

        def model = controller.show()

        assert model.teamsInstance == teams
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/teams/list'

        populateValidParams(params)
        def teams = new Teams(params)

        assert teams.save() != null

        params.id = teams.id

        def model = controller.edit()

        assert model.teamsInstance == teams
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/teams/list'

        response.reset()

        populateValidParams(params)
        def teams = new Teams(params)

        assert teams.save() != null

        // test invalid parameters in update
        params.id = teams.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/teams/edit"
        assert model.teamsInstance != null

        teams.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/teams/show/$teams.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        teams.clearErrors()

        populateValidParams(params)
        params.id = teams.id
        params.version = -1
        controller.update()

        assert view == "/teams/edit"
        assert model.teamsInstance != null
        assert model.teamsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/teams/list'

        response.reset()

        populateValidParams(params)
        def teams = new Teams(params)

        assert teams.save() != null
        assert Teams.count() == 1

        params.id = teams.id

        controller.delete()

        assert Teams.count() == 0
        assert Teams.get(teams.id) == null
        assert response.redirectedUrl == '/teams/list'
    }
}
