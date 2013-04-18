package backend

import static org.junit.Assert.*
import org.junit.*

class TeamsServiceTests extends GroovyTestCase  {

    @Before
    void setUp() {
        // Setup logic here
    }

    @After
    void tearDown() {
        // Tear down logic here
    }

    @Test
    void testAllTeams() {
        TeamsService teamsService = new TeamsService()
        def teams = teamsService.allTeams()
    }
}
