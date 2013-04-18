package lu.intech.intoads.db;

import java.net.URL;

import lu.intech.intoads.db.enums.DBAccessType;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

public class DBConnector {
	
	protected static final String DB_NAME = "InToads.db";
	protected static final int DB_VERSION = 1;
	
	protected DBOpenHelper dbOpenHelper;
	protected SQLiteDatabase sqliteDatabase;
	protected URL url;
	protected Context context;
	
	public DBConnector(Context context){
		this.context = context;
		this.dbOpenHelper = new DBOpenHelper(context, DB_NAME, null, DB_VERSION);
	}
	
	/**
	 * By default, only accept read access
	 */
	public void open(){
		this.open(null);
	}
	
	public void open(String type){
		if ( DBAccessType.READ_WRITE.getType().equals(type) ) {
			this.sqliteDatabase = this.dbOpenHelper.getWritableDatabase();
		} else { 
			this.sqliteDatabase = this.dbOpenHelper.getReadableDatabase();
		}
	}
	
	public void close(){
		this.sqliteDatabase.close();
	}
	
	public SQLiteDatabase getDB(){
		return this.sqliteDatabase;
	}
}
