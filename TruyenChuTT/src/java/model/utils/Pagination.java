/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.utils;

public class Pagination {
    private int currentPage;     // Trang hiện tại
    private int pageSize;        // Số lượng phần tử mỗi trang
    private int totalItems;      // Tổng số phần tử
    private int totalPages;      // Tổng số trang

    public Pagination(int currentPage, int pageSize, int totalItems) {
        this.pageSize = (pageSize <= 0) ? 10 : pageSize;
        this.totalItems = Math.max(totalItems, 0);
        this.totalPages = (int) Math.ceil((double) this.totalItems / this.pageSize);
        this.currentPage = (currentPage <= 0) ? 1 : Math.min(currentPage, totalPages == 0 ? 1 : totalPages);
    }

    public int getOffset() {
        return (currentPage - 1) * pageSize;
    }

    public int getLimit() {
        return pageSize;
    }

    public boolean hasPreviousPage() {
        return currentPage > 1;
    }

    public boolean hasNextPage() {
        return currentPage < totalPages;
    }

    public int getPreviousPage() {
        return hasPreviousPage() ? currentPage - 1 : 1;
    }

    public int getNextPage() {
        return hasNextPage() ? currentPage + 1 : totalPages;
    }

    // Getters
    public int getCurrentPage() {
        return currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public int getTotalPages() {
        return totalPages;
    }

    // Setters nếu cần (bạn có thể để immutable nếu muốn an toàn)
    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
        this.totalPages = (int) Math.ceil((double) totalItems / pageSize);
        this.currentPage = Math.min(currentPage, totalPages);
    }
}

