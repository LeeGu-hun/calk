package org.calk.domain;

import lombok.Data;

@Data
public class MemberVO {
	private int customer_id;
	private String cust_first_name, cust_last_name, 
		cust_street_address1,cust_street_address2,cust_city,
		cust_postal_code,phone_number1,phone_number2;
	private int credit_limit;
	private String cust_email;
}
