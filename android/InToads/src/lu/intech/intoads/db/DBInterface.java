package lu.intech.intoads.db;

import java.io.IOException;
import java.net.MalformedURLException;

import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.DOMException;
import org.xml.sax.SAXException;

import android.database.Cursor;

/**
 * DB Interface
 * 
 * @author sebastien
 *
 */
public interface DBInterface<Entry> {
	public Entry getFromId(long i);
	public Cursor getListCursor();
	public Entry convertCursorToEntry(Cursor c);
	public long insert(Entry entry);
	public int update(Entry entry);
	public boolean isExist(int id);
	public int delete(Entry news);
	public int delete(int id);
	public void updateTableFromXML() throws DOMException, IOException, ParserConfigurationException, SAXException, MalformedURLException;
}
