package ws

import play.api.libs.ws.WS
import play.api.libs.json.{JsArray, JsValue}
import scala.concurrent.{Future}
import concurrent.ExecutionContext.Implicits.global

/**
 * User: antoine
 * Date: 18/04/13 19:52
 */
object BackendServices {

  private val backend = "http://192.168.4.136:9000"


  case class Rider(id:String,name:String,twitter:Option[String], teamName:String, teamId:String)
  case class Team(id:String,name:String,riders:Seq[Rider])

  def getRiderDetail(idRider:String):Future[Rider] =
    WS.url(backend+ "/rider/"+idRider).get().map(_.json).map{json=>
      Rider(
        id = (json \ "id").as[String],
        name = (json \ "name").as[String],
        twitter = (json \ "twitter").as[Option[String]],
        teamName = (json \ "team"\"name").as[String],
        teamId = (json \ "team" \"id").as[String]
      )
    }

  def getTeams:Future[Seq[Team]]=
    WS.url(backend + "/teams").get().map(_.json).flatMap{teams=>
      Future.sequence(teams.asInstanceOf[JsArray].value.map{team=>
        WS.url(backend + "/team/"+((team \ "id").as[String])).get().map(_.json).map{riders=>
          riders.asInstanceOf[JsArray].value.map{rider=>
            Rider((rider \ "id").as[String],(rider \ "name").as[String],None,(team \ "id").as[String],(team \"name").as[String])
          }
        }.map{riders=>
          Team((team\"id").as[String],(team\"name").as[String],riders)
        }
      })
    }


}
