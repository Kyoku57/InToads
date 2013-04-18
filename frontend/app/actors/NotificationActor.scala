package actors

import akka.actor.{Props, Actor}
import play.api.Logger
import play.api.libs.concurrent.Akka
import play.api.libs.json.{JsValue, Json}

/**
 * User: antoine
 * Date: 17/04/13 22:21
 */
object Notification{

  import play.api.Play.current

  private val logger = Logger("intoads.actor.notifications")

  class NotificationActor extends Actor{
    def receive = {

      case ("position",data:JsValue) =>
        logger.debug("Position received " + data)
        Akka.system.eventStream.publish(Json.obj(
          "type"    -> "position",
          "data" -> data
        ))

      case ("lap-start",data:JsValue) =>
        logger.debug("Lap start received " + data)
        Akka.system.eventStream.publish(Json.obj(
          "type"    -> "lap-start",
          "data" -> data
        ))

      case ("lap-end",data:JsValue) =>
        logger.debug("Lap end received " + data)
        Akka.system.eventStream.publish(Json.obj(
          "type"    -> "lap-end",
          "data" -> data
        ))

      case _ => logger.warn("Received unknown message")
    }
  }


  private lazy val actor = Akka.system.actorOf(Props[NotificationActor], name = "notifications")

  def newNotification(typeNotif:String,data:JsValue) = actor ! (typeNotif,data)
}