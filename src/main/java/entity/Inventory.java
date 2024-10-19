package entity;

public class Inventory {
	private Long id;
	private int stock;

	public Inventory(Long id, int stock) {
		this.id = id;
		this.stock = stock;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

}
