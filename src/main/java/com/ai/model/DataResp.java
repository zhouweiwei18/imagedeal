package com.ai.model;

import java.io.Serializable;

/**
 * 响应数据实体
 */
public class DataResp implements Serializable {
    private String message;
    private int code;
    private Object data;

    public interface Code{
        int SUCCESS = 0;
        int ERROR = 1;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
