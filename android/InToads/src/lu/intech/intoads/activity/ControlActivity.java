package lu.intech.intoads.activity;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;

import lu.intech.intoads.R;
import lu.intech.intoads.geolocalisation.GPSTracker;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.app.Activity;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import lu.intech.intoads.R;
import lu.intech.intoads.geolocalisation.GPSTracker;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import android.view.View;
import android.widget.Button;
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
		//ToDo : GetRiders
		//ToDo : SaveRiders
		
		//On select
		//ToDo : Save pref
		//ToDo : Enable start button

		/*Spinner spinner = (Spinner) findViewById(R.id.team_spinnerR);
		ArrayAdapter<CharSequence> adapter = ArrayAdapter
				.createFromResource(this, R.array.array_team,
						android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinner.setAdapter(adapter);
		
		
		
		spinner.setOnItemSelectedListener(new OnItemSelectedListener() {

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
	
	public void loadTeams(ArrayList<Team> listTeam){
		Spinner spinner = (Spinner) findViewById(R.id.team_spinner);
		/*ArrayAdapter<CharSequence> adapter = ArrayAdapter
				.createFromResource(this, R.array.array_team,
						android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinner.setAdapter(adapter);*/
	}

}
