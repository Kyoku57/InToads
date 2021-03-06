package models

 case class Rider(id:String,name:String,twitter:Option[String], teamName:String, teamId:String)
 case class Team(id:String,name:String,riders:Seq[Rider])
 case class RiderStats(riderid:String,bestlap:Int,status:String,laps:Int)
 