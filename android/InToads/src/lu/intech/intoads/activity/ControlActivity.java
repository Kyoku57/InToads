package lu.intech.intoads.activity;

import java.util.ArrayList;

import lu.intech.intoads.R;
import lu.intech.intoads.geolocalisation.GPSTracker;
import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;


public class ControlActivity extends Activity {


    
    Button btnStart;
    
    // GPSTracker class
    GPSTracker gps;
  
    


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_control);		
		
		//ToDo : GetTeams & Save
		GetTeamsAsync gta = new GetTeamsAsync(this);
		gta.execute();
		
		Spinner spinner = (Spinner) findViewById(R.id.team_spinner);
		
		btnStart = (Button) findViewById(R.id.button_start);
		 
        // show location button click event
        btnStart.setOnClickListener(new View.OnClickListener() {
 
            @Override
            public void onClick(View arg0) {
                // create class object
                gps = new GPSTracker(ControlActivity.this);
 
                // check if GPS enabled
                if(gps.canGetLocation()){
 
                    double latitude = gps.getLatitude();
                    double longitude = gps.getLongitude();
 
                    // \n is for new line
                    Toast.makeText(getApplicationContext(), "Your Location is - \nLat: " + latitude + "\nLong: " + longitude, Toast.LENGTH_LONG).show();
                }else{
                    // can't get location
                    // GPS or Network is not enabled
                    // Ask user to enable GPS/network in settings
                    gps.showSettingsAlert();
                }
 
            }
        });
		
		//On select
		//TODO : GetRiders
		//TODO : SaveRiders
		
		//On select
		//TODO : Save pref
		//TODO : Enable start button
        
        
        
        
		/*spinner.setOnItemSelectedListener(new OnItemSelectedListener() {

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
		});*/
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.control, menu);
		return true;
	}
	
	/**
	 * M�thode qui charge le spinner Team avec la liste des Team pass�e en param�tre
	 * @param listTeam la liste des Team 
	 */
	public void loadTeams(ArrayList<Team> listTeam){
		//On r�cup�re le spinner pour les teams
		Spinner spinner = (Spinner) findViewById(R.id.team_spinner);
		
		//Cr�ation de l'adapter, fournit avec la liste des Team
		ArrayAdapter<Team> adapter = new ArrayAdapter<Team>(this, android.R.layout.simple_spinner_item,	listTeam);
		
		//Le spinner de team utilise l'adapter pr�c�demment cr��
		spinner.setAdapter(adapter);
	}

}
