package lu.intech.intoads.data;

public class RiderEntity {

	private String riderId;
	
	private String name;

	public RiderEntity(String riderId, String name) {
		this.riderId = riderId;
		this.name = name;
	}
	
	public String getRiderId() {
		return riderId;
	}

	public void setRiderId(String riderId) {
		this.riderId = riderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
