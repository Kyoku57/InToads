package actors

import akka.actor.{Props, Actor}
import play.api.Logger
import play.api.libs.concurrent.Akka
import play.api.libs.json.{JsValue, Json}
import ws.BackendServices
import concurrent.ExecutionContext.Implicits.global

/**
 * User: antoine
 * Date: 17/04/13 22:21
 */
object Notification{

  import play.api.Play.current

  private val logger = Logger("intoads.actor.notifications")

  class NotificationActor extends Actor{
    def receive = {

      case ("position",data:JsValue,idRider:String) =>
        logger.debug("Position received " + data)
        BackendServices.getRiderDetail(idRider).map{rider=>
          Akka.system.eventStream.publish(Json.obj(
            "type"    -> "position",
            "data" -> data,
            "rider" -> Json.obj(
              "id"-> rider.id,
              "name" -> rider.name,
              "twitter" -> rider.twitter,
              "twitter" -> rider.twitter,
              "teamId" -> rider.teamId,
              "teamName" -> rider.teamName
            )
          ))
        }

      case ("lap-start",data:JsValue,idRider:String) =>
        logger.debug("Lap start received " + data)
        BackendServices.getRiderDetail(idRider).map{rider=>
          Akka.system.eventStream.publish(Json.obj(
            "type"    -> "lap-start",
            "data" -> data,
            "rider" -> Json.obj(
              "id"-> rider.id,
              "name" -> rider.name,
              "twitter" -> rider.twitter,
              "twitter" -> rider.twitter,
              "teamId" -> rider.teamId,
              "teamName" -> rider.teamName
            )
          ))
        }

      case ("lap-end",data:JsValue,idRider:String) =>
        logger.debug("Lap end received " + data)
        BackendServices.getRiderDetail(idRider).map{rider=>
          Akka.system.eventStream.publish(Json.obj(
            "type"    -> "lap-end",
            "data" -> data,
            "rider" -> Json.obj(
              "id"-> rider.id,
              "name" -> rider.name,
              "twitter" -> rider.twitter,
              "teamId" -> rider.teamId,
              "teamName" -> rider.teamName
            )
          ))
        }

      case _ => logger.warn("Received unknown message")
    }
  }


  private lazy val actor = Akka.system.actorOf(Props[NotificationActor], name = "notifications")

  def newNotification(typeNotif:String,data:JsValue, idRider:String) = actor ! (typeNotif,data,idRider)
}