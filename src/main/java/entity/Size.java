package entity;

public class Size {
	private Long id;
	private String name;
	private Long sizeTypeId;
	
	

	public Size() {
		super();
	}

	public Size(Long id, String name, Long sizeTypeId) {
		this.id = id;
		this.name = name;
		this.sizeTypeId = sizeTypeId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getSizeTypeId() {
		return sizeTypeId;
	}

	public void setSizeTypeId(Long sizeTypeId) {
		this.sizeTypeId = sizeTypeId;
	}

}
