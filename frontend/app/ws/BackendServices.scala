package ws

import play.api.libs.ws.WS
import play.api.libs.json.JsValue
import scala.concurrent.Future
import concurrent.ExecutionContext.Implicits.global
import models._
/**
 * User: antoine
 * Date: 18/04/13 19:52
 */
object BackendServices {

  private val backend = "http://192.168.4.136:9000"


  

  def getRiderDetail(idRider:String):Future[Rider] =
    WS.url(backend+ "/rider/"+idRider).get().map(_.json).map{json=>
      Rider(
        id = (json \ "id").as[String],
        name = (json \ "name").as[String],
        twitter = (json \ "twitter").as[Option[String]]
      )
    }

}
