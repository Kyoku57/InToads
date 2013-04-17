package controllers

import play.api._
import play.api.mvc._
import play.api.libs.json.Json
import java.util.Date
import java.text.SimpleDateFormat

object Application extends Controller {
  
  def teams = Action{
    println("/teams requested")
    Ok(
      Json.toJson(List(
        "team1" -> "Les Walker Texas",
        "team2" -> "Les visages Papals",
        "team3" -> "Nico Unchained"
      ).map{team=>
        Json.obj(
          "id"    -> team._1,
          "name"  -> team._2
        )
      })
    )
  }

  def team(id:String) =  Action{
    println("/team requested for teamId "+id)
    Ok(
      Json.toJson(List(
        "SDE" -> "Sébastien",
        "AAA" -> "Anthony",
        "CTN" -> "Camille",
        "MBR" -> "Michael",
        "WTI" -> "Wilfried"
      ).map{team=>
        Json.obj(
          "id"    -> team._1,
          "name"  -> team._2
        )
      })
    )
  }

  def rider(id:String) =  Action{
    println("/rider requested for riderId "+id)
    Ok(
      Json.obj(
        "id" -> "SDE",
        "name" -> "Sébastien",
        "twitter" -> "Kyoku57"
      )
    )
  }

  def savePosition(id:String) = Action(parse.json){request=>
    println("/position requested for riderId "+id)
    request.body.validate[Position].map{pos=>
      println("JSON is OK")
      Ok(
        Json.obj(
          "succes" -> true,
          "debug" -> Json.obj(
            "rider" -> id,
            "lat"   -> pos.latitude,
            "long"  -> pos.longitude,
            "alti"   -> pos.altitude,
            "time"  -> new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(pos.date)
          )
        )
      )
    }.recover{
      case error =>
        println("JSON isn't valid: ")
        println("Received : "+request.body.toString())
        error.errors.foreach{err=>
          err._2.foreach(m=>println(m.message))
        }
        BadRequest(
          "Invalid JSON : " +
          error.errors.map(err=>err._2.map(_.message).mkString("\n")).mkString("\n")
           + " received data : "+request.body.toString())
    }.getOrElse(BadRequest("Invalid JSON :\n"+request.body.toString()))
  }

  def lap(riderId:String, notifType:String) = Action(parse.json){ request=>
    if(notifType=="start") println("start lap for rider "+riderId+" received")
    else println("end lap for rider "+riderId+" received")
    request.body.validate[Position].map{pos=>
      println("JSON is OK")
      Ok(
        Json.obj(
          "succes" -> true,
          "debug" -> Json.obj(
            "rider" -> riderId,
            "lat"   -> pos.latitude,
            "long"  -> pos.longitude,
            "alti"   -> pos.altitude,
            "time"  -> new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(pos.date)
          )
        )
      )
    }.recover{
      case error =>
        println("JSON isn't valid: ")
        println("Received : "+request.body.toString())
        error.errors.foreach{err=>
          err._2.foreach(m=>println(m.message))
        }
        BadRequest(
          "Invalid JSON : " +
            error.errors.map(err=>err._2.map(_.message).mkString("\n")).mkString("\n")
            + " received data : "+request.body.toString())
    }.getOrElse(BadRequest("Invalid JSON :\n"+request.body.toString()))
  }


  case class Position(latitude:Double,longitude:Double,altitude:Double,date:Date)

  import play.api.libs.json._
  import play.api.libs.functional.syntax._

  implicit val positionReads = (
    (__ \ "lat").read[Double] and
    (__ \ "long").read[Double] and
    (__ \ "alti").read[Double] and
    (__ \ "time").read[Long]
    )((lat,long,alt,time)=>Position(lat,long,alt,new Date(time)))

}