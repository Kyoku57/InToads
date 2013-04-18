package lu.intech.intoads.db;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;

public class PositionsDAO extends DBConnector implements DBInterface<PositionEntity>{

	private final String[] SELECT = {
			DBOpenHelper.POSITION_COL_ID,
			DBOpenHelper.POSITION_FK_RIDER_ID,
			DBOpenHelper.POSITION_COL_LATITUDE,
			DBOpenHelper.POSITION_COL_LONGITUDE,
			DBOpenHelper.POSITION_COL_ALTITUDE,
			DBOpenHelper.POSITION_COL_DATETIME,
			DBOpenHelper.POSITION_TYPE
	};
	
	public PositionsDAO(Context context) {
		super(context);
	}

	@Override
	public PositionEntity getFromId(long id) {
		Cursor c = this.sqliteDatabase.query(DBOpenHelper.POSITION_TABLE_NAME, 
					SELECT,
					DBOpenHelper.POSITION_COL_ID + " = \"" + id +"\"", 
					null, null, null, null);
		
		return convertCursorToEntry(c);
	}

	@Override
	public Cursor getListCursor() {
		Cursor c = this.sqliteDatabase.query(DBOpenHelper.POSITION_TABLE_NAME, 
				SELECT , null, 
				null , null, null, null);
		return c;
	}

	@Override
	public PositionEntity convertCursorToEntry(Cursor cursor) {
		if (cursor.getCount() == 0)
			return null;

		cursor.moveToFirst();
		PositionEntity position = new PositionEntity();
		
		position.setId(cursor.getLong(cursor.getColumnIndex(DBOpenHelper.POSITION_COL_ID)));
		position.setRiderId(cursor.getLong(cursor.getColumnIndex(DBOpenHelper.POSITION_FK_RIDER_ID)));
		position.setLatitude(cursor.getDouble(cursor.getColumnIndex(DBOpenHelper.POSITION_COL_LATITUDE)));
		position.setLongitude(cursor.getDouble(cursor.getColumnIndex(DBOpenHelper.POSITION_COL_LONGITUDE)));
		position.setAltitude(cursor.getDouble(cursor.getColumnIndex(DBOpenHelper.POSITION_COL_ALTITUDE)));
		position.setTimestamp(cursor.getLong(cursor.getColumnIndex(DBOpenHelper.POSITION_COL_DATETIME)));
		position.setPositionType(cursor.getString(cursor.getColumnIndex(DBOpenHelper.POSITION_TYPE)));
		cursor.close();

		return position;
	}

	@Override
	public long insert(PositionEntity position) {
		ContentValues values = new ContentValues();
		if (position.getId() > 0) {
			values.put(DBOpenHelper.POSITION_COL_ID, position.getId());
		}
		values.put(DBOpenHelper.POSITION_FK_RIDER_ID, position.getRiderId());
		values.put(DBOpenHelper.POSITION_COL_LATITUDE, position.getLatitude());
		values.put(DBOpenHelper.POSITION_COL_LONGITUDE, position.getLongitude());
		values.put(DBOpenHelper.POSITION_COL_ALTITUDE, position.getAltitude());
		values.put(DBOpenHelper.POSITION_COL_DATETIME, position.getTimestamp());
		values.put(DBOpenHelper.POSITION_TYPE, position.getPositionType());
		
		return this.sqliteDatabase.insert(DBOpenHelper.POSITION_TABLE_NAME, null, values);
	}
	
	/**
	 * Insert a list of position
	 * 
	 * @param positionList
	 * @return
	 */
	public List<Long> insert(List<PositionEntity> positionList) {
		List<Long> resultList = new ArrayList<Long>();
		if (positionList != null) {
			for (PositionEntity entity : positionList) {
				resultList.add(this.insert(entity));
			}
		}
		return resultList;
	}

	@Override
	public int update(PositionEntity position) {
		ContentValues values = new ContentValues();
		values.put(DBOpenHelper.POSITION_FK_RIDER_ID, position.getRiderId());
		values.put(DBOpenHelper.POSITION_COL_LATITUDE, position.getLatitude());
		values.put(DBOpenHelper.POSITION_COL_LONGITUDE, position.getLongitude());
		values.put(DBOpenHelper.POSITION_COL_ALTITUDE, position.getAltitude());
		values.put(DBOpenHelper.POSITION_COL_DATETIME, position.getTimestamp());
		values.put(DBOpenHelper.POSITION_TYPE, position.getPositionType());
		return this.sqliteDatabase.update(DBOpenHelper.POSITION_TABLE_NAME, values, 
				DBOpenHelper.POSITION_COL_ID + " = " + position.getId(), null);
	}

	@Override
	public int delete(PositionEntity position) {
		return this.sqliteDatabase.delete(DBOpenHelper.POSITION_TABLE_NAME, 
				DBOpenHelper.POSITION_COL_ID + " = " + position.getId(), null);
	}

	@Override
	public int delete(int id) {
		return this.sqliteDatabase.delete(DBOpenHelper.POSITION_TABLE_NAME, 
				DBOpenHelper.POSITION_COL_ID + " = " + id, null);
	}

	@Override
	public boolean isExist(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	/**
	 * Get last Position x limit
	 * 
	 * @param limit
	 * @return
	 */
	public List<PositionEntity> getLastPositions(int limit) {
		List<PositionEntity> positionList = new ArrayList<PositionEntity>();
		return positionList;
	}
	
	/**
	 * Delete a PositonEntity list
	 * 
	 * @param positionList
	 * @return
	 */
	public int delete(List<PositionEntity> positionList) {
		int result = 0;
		if (positionList != null) {
			for (PositionEntity entity : positionList) {
				result = result + this.delete(entity);
			}
		}
		return result;
	}
}
