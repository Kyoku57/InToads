package controllers

import play.api._
import play.api.mvc._
import actors.Notification
import akka.actor.{Props, Actor}
import play.api.libs.iteratee.{Enumerator, Concurrent}
import play.api.libs.json.{JsArray, Json, JsValue}
import play.libs.Akka
import scala.concurrent.duration._
import akka.util.Timeout
import play.api.libs.EventSource
import akka.pattern.ask
import concurrent.ExecutionContext.Implicits.global
import java.util.Date
import models._
import ws.BackendServices


object Application extends Controller {
  def index = Action {
    Ok(views.html.index())
  }
  def stats = Action {Async{
    BackendServices.getTeams.map{teams=> Ok(views.html.stats(teams))}
  
  } 
   
    

    
  }

  def position(riderId:String) = Action(parse.json){request=>
    Notification.newNotification("position",request.body,riderId)
    Ok("ok")
  }

  def lap(riderId:String, start:Boolean) = Action(parse.json){request=>
    val typeNotif = "lap-" + (if(start) "start" else "end")
    Notification.newNotification(typeNotif,request.body,riderId)
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

  def teams = Action{
    Async{
      BackendServices.getTeams.map{teams=>
        Ok(JsArray( teams.map{team=>
          Json.obj(
            "id"-> team.id,
            "name" -> team.name,
            "riders" -> team.riders.map{rider=>Json.obj(
                "id" -> rider.id,
                "name" -> rider.name
              )
            }
          )
        }))
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