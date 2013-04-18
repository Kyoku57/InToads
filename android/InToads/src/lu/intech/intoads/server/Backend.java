package lu.intech.intoads.server;

import java.util.ArrayList;

import lu.intech.intoads.data.PositionEntity;
import lu.intech.intoads.data.RiderEntity;
import lu.intech.intoads.data.TeamEntity;

public class Backend {

	public static boolean startLap(PositionEntity position) {

		return false;
	}

	public static boolean stopLap(PositionEntity position) {

		return false;
	}
	
	public static boolean savePosition(PositionEntity[] position) {
		
		return false;
	}
	
	public static ArrayList<TeamEntity> getTeams() {
	
		ArrayList<TeamEntity> result = new ArrayList<TeamEntity>();
		result.add(new TeamEntity("team1", "Les Walker Texas Riders"));
		result.add(new TeamEntity("team2", "Les visages Papals"));
		result.add(new TeamEntity("team3", "Nico Unchained"));
		return result;
	}
	
	public static ArrayList<RiderEntity> getRiders(String teamId) {
		
		ArrayList<RiderEntity> result = new ArrayList<RiderEntity>();
		result.add(new RiderEntity("SDE", "SŽbastien"));
		result.add(new RiderEntity("AAA", "Anthony"));
		result.add(new RiderEntity("CTN", "Camille"));
		result.add(new RiderEntity("MBR", "Michael"));
		result.add(new RiderEntity("WTI", "Wilfried"));
		return result;
	}
}
