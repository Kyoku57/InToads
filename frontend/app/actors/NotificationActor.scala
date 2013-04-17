package actors

import akka.actor.{Props, Actor}
import play.api.Logger
import play.api.libs.concurrent.Akka
import play.api.libs.json.Json

/**
 * User: antoine
 * Date: 17/04/13 22:21
 */
object Notification{

  import play.api.Play.current

  private val logger = Logger("intoads.actor.notifications")

  class NotificationActor extends Actor{
    def receive = {
      case Message(msg) =>
        logger.debug("Received " + msg)
        Akka.system.eventStream.publish(Json.obj(
          "type"    -> "newMessage",
          "message" -> msg
        ))

      case _ => logger.warn("Received unknown message")
    }
  }

  case class Message(value:String)

  private lazy val actor = Akka.system.actorOf(Props[NotificationActor], name = "notifications")

  def newMessage(msg:Message) = actor ! msg
}