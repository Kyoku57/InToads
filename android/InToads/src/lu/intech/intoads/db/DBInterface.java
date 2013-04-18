package lu.intech.intoads.db;

<<<<<<< HEAD
=======
import java.io.IOException;
import java.net.MalformedURLException;

import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.DOMException;
import org.xml.sax.SAXException;

>>>>>>> d05b757b3834d334a0563593bfa58f41384aaece
import android.database.Cursor;

/**
 * DB Interface
 * 
 * @author sebastien
 *
 */
public interface DBInterface<Entity> {
	
	public Entity getFromId(long id);
	
	public Cursor getListCursor();
	
	public Entity convertCursorToEntry(Cursor cursor);
	
	public long insert(Entity entry);
	
	public int update(Entity entry);
	
	public boolean isExist(int id);
	
	public int delete(Entity entry);
	
	public int delete(int id);
}
