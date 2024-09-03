package common.utils.common;

import java.util.List;

public class PagingConfig {

    String pageNo = "1";
    String limit = "100";  // 기본 limit을 100으로 설정 (또는 원하는 기본값으로 설정)
    List<PagingConfigOrder> orders;

    public String getPageNo() {
        return pageNo;
    }

    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    public String getLimit() {
        return limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }

    public List<PagingConfigOrder> getOrders() {
        return orders;
    }

    public void setOrders(List<PagingConfigOrder> orders) {
        this.orders = orders;
    }

    @Override
    public String toString() {
        return "ConfigPage [pageNo=" + pageNo + ", limit=" + limit + ", orders=" + orders + "]";
    }
}
