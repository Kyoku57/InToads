package controllers

import play.api._
import play.api.mvc._
import actors.Notification
import actors.Notification.Message
import akka.actor.{Props, Actor}
import play.api.libs.iteratee.{Enumerator, Concurrent}
import play.api.libs.json.JsValue
import play.libs.Akka
import scala.concurrent.duration._
import akka.util.Timeout
import play.api.libs.EventSource
import akka.pattern.ask
import concurrent.ExecutionContext.Implicits.global
import java.util.Date

object Application extends Controller {
  
  def index = Action {
    Ok(views.html.index())
  }

  def notif = Action(parse.json){request=>
    Notification.newMessage(Message((request.body \ "message").as[String]+ " "+new Date().getTime))
    Ok("ok")
  }

  def liveStream = Action {
    AsyncResult {
      implicit val timeout = Timeout(5 seconds)
      val actor = Akka.system.actorOf(Props[EventsListener])
      (actor ? "start").mapTo[Enumerator[JsValue]].map {
        chunks =>
          Ok.stream((chunks) &> EventSource()).as("text/event-stream")
      }
    }
  }

  class EventsListener extends Actor {
    val (output, channel) = Concurrent.broadcast[JsValue]
    // TODO : stop actor on channel disconnection
    def receive = {
      case "start" =>
        Akka.system.eventStream.subscribe(self, classOf[JsValue])
        sender ! output
      case event:JsValue =>
        channel.push(event)
      case _ =>
    }
  }
  
}