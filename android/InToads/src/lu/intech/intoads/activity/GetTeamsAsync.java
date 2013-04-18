package lu.intech.intoads.activity;

import java.util.ArrayList;

import android.os.AsyncTask;

public class GetTeamsAsync extends AsyncTask<Void, Void, Void> {
	
	private ControlActivity activity;
	private ArrayList<Team> list;
	
	public GetTeamsAsync(ControlActivity act){
		activity = act;
	}

	@Override
	protected Void doInBackground(Void... params) {
		//list = getTeams();
		//saveTeam
		return null;
	}
	
	@Override
	protected void onPostExecute(Void response) {
		 //activity.loadTeams(list);
	 }
	 
	 
}
