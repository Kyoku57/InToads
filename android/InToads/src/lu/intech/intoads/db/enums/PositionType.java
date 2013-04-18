package lu.intech.intoads.db.enums;

public enum PositionType {
	START("START"),
	CURRENT("CURRENT"),
	END("END");
	
	private String type;
	
	PositionType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
}
