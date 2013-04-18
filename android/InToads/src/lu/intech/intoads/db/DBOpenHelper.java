package lu.intech.intoads.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;

public class DBOpenHelper extends SQLiteOpenHelper{

	public static final String POSITION_TABLE_NAME = "PositionsBuffer";
	public static final String POSITION_COL_ID = "id";
	public static final String POSITION_FK_RIDER_ID = "riderId";
	public static final String POSITION_COL_LATITUDE = "latitude";
	public static final String POSITION_COL_LONGITUDE = "longitude";
	public static final String POSITION_COL_ALTITUDE = "altitude";
	public static final String POSITION_COL_DATETIME = "dateTimeSynchro"; 
	public static final String POSITION_TYPE = "positionType";
	
		
	public DBOpenHelper(Context context, String name, CursorFactory factory, int version) {
		super(context, name, factory, version);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// position datas
		db.execSQL("CREATE TABLE " + POSITION_TABLE_NAME + " ("
				+ POSITION_COL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
				+ POSITION_FK_RIDER_ID + " REAL NOT NULL, "
				+ POSITION_COL_LATITUDE + " REAL NOT NULL, "
				+ POSITION_COL_LONGITUDE + " REAL NOT NULL, "				
				+ POSITION_COL_ALTITUDE + " REAL NOT NULL, "
				+ POSITION_COL_DATETIME + " INTEGER NOT NULL, "
				+ POSITION_TYPE + " TEXT NOT NULL"
				+ ");");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		
	}
}
