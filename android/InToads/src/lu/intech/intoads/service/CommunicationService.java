package lu.intech.intoads.service;

import java.util.Timer;
import java.util.TimerTask;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;

/*
 * author : nsanitas
 * goal : handle the periodic send of geolocation data to back(front)-end
 */

public class CommunicationService extends Service {

	// constant
	public static final long NOTIFY_INTERVAL = 30 * 1000; // 30 seconds

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
		mTimer.scheduleAtFixedRate(new SendPosition(), 0, NOTIFY_INTERVAL);
	}

	class SendPosition extends TimerTask {

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
