package lu.intech.intoads.db.enums;

public enum DBAccessType {

	READ_ONLY("r"),
	READ_WRITE("rw");
	
	private String type;

	DBAccessType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
}
