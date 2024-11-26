package com.emotionlog.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QboardVO {
    private Long qno;                
    private String qtitle;           
    private String qcontent;         
    private Date qdate;             
    private Long username;           
    private Long ano;               
    private Date qupdate_date;       
}

