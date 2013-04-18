package lu.intech.intoads.activity;

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

public class ControlActivity extends Activity {


    
    Button btnStart;
    
    // GPSTracker class
    GPSTracker gps;
  
    


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_control);
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


		/*Spinner spinner = (Spinner) findViewById(R.id.team_spinner);
		// Create an ArrayAdapter using the string array and a default spinner
		// layout
		ArrayAdapter<CharSequence> adapter = ArrayAdapter
				.createFromResource(this, R.array.array_team,
						android.R.layout.simple_spinner_item);
		// Specify the layout to use when the list of choices appears
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		// Apply the adapter to the spinner
		spinner.setAdapter(adapter);*/
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.control, menu);
		return true;
	}

}
