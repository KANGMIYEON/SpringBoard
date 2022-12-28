package com.ezen.myProject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class FileVO {
	
		private String uuid;
		private String save_dir; // 저장경로
		private String file_name;
		private int file_type;
		private int bno;
		private long file_size;
		private String reg_at;
		
}
