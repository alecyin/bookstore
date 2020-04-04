package com.bookstore.util;

public enum ResCode {
    SUCCESS(20000), FAIL(60204), NOLOGIN(50008);

    private final int code;

    ResCode(Integer code){
        this.code = code;
    }

    public int code() {
        return code;
    }
}
