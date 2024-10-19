package dto.response;

import java.util.List;

public class PaginationResponse {
	private List<?> data; // Danh sách dữ liệu (các đối tượng T)
	private int currentPage; // Trang hiện tại
	private int pageSize; // Số bản ghi trên mỗi trang
	private long totalRecords; // Tổng số bản ghi
	private int totalPages; // Tổng số trang

	public PaginationResponse() {
	}

	public PaginationResponse(List<?> data, int currentPage, int pageSize, long totalRecords, int totalPages) {
		super();
		this.data = data;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalRecords = totalRecords;
		this.totalPages = totalPages;
	}

	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(long totalRecords) {
		this.totalRecords = totalRecords;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

}
