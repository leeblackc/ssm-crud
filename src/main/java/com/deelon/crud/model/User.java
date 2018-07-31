package com.deelon.crud.model;

public class User {
    private Integer userid;

    private String username;

    private String account;

    private String password;

    private Integer type;

    
    
    public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(Integer userid, String username, String account, String password, Integer type) {
		super();
		this.userid = userid;
		this.username = username;
		this.account = account;
		this.password = password;
		this.type = type;
	}

	public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}