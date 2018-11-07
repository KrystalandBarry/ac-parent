package com.atguigu.ac.entities;

import java.util.ArrayList;
import java.util.List;

public class Permission {
	private Integer id;

	private Integer pid;

	// 必须和zTree设定的属性名一致
	private String name;

	// 必须和zTree设定的属性名一致
	private String icon;

	// 必须和zTree设定的属性名一致
	private Boolean open = true;

	// 必须和zTree设定的属性名一致
	// 这个属性必须初始化，否则后续添加子节点时会有空指针异常
	private List<Permission> children = new ArrayList<>();

	private String url;

	private Boolean checked;

	public Permission(Integer id, Integer pid, String name, String icon, Boolean open, List<Permission> children,
			String url) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.icon = icon;
		this.open = open;
		this.children = children;
		this.url = url;
	}

	public Permission() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Boolean getOpen() {
		return open;
	}

	public void setOpen(Boolean open) {
		this.open = open;
	}

	public List<Permission> getChildren() {
		return children;
	}

	public void setChildren(List<Permission> children) {
		this.children = children;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon == null ? null : icon.trim();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url == null ? null : url.trim();
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	@Override
	public String toString() {
		return "Permission [id=" + id + ", pid=" + pid + ", name=" + name + ", icon=" + icon + ", open=" + open
				+ ", children=" + children + ", url=" + url + "]";
	}

}