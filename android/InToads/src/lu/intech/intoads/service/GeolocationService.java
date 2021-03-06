package lu.intech.intoads.service;

import java.util.Timer;
import java.util.TimerTask;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;

/*
 * author : nsanitas
 * goal : handle the periodic capture of geolocation data to back(front)-end
 */

public class GeolocationService extends Service {

	// constant
	// TODO : define this in a 'settings' screen?
	public static final long NOTIFY_INTERVAL = 20 * 1000; // 20 seconds

	// run on another Thread to avoid crash
	private Handler mHandler = new Handler();
	// timer handling
	private Timer mTimer = null;

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public void onCreate() {
		// cancel if already existed
		if(mTimer != null) {
			mTimer.cancel();
		} else {
			// recreate new
			mTimer = new Timer();
		}
		// schedule task
		mTimer.scheduleAtFixedRate(new StorePosition(), 0, NOTIFY_INTERVAL);
	}

	class StorePosition extends TimerTask {

		@Override
		public void run() {
			// run on another thread
			mHandler.post(new Runnable() {

				@Override
				public void run() {
					// vas-y baby fous ton code ici !
				}

			});
		}
	}
}
