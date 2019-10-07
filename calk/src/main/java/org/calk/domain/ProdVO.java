package org.calk.domain;

import java.sql.Blob;
import java.util.Date;

import lombok.Data;

@Data
public class ProdVO {
	private int product_id;
	private String product_name, product_description;
	private String category, product_avail;
	private int list_price;
	private Blob product_image;
	private String mimetype, filename;
	private Date image_last_update;
}
