package com.ezen.myProject.handler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.myProject.domain.FileVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@AllArgsConstructor
@Component // servlet-context 에서 25 라인
public class FileHandler {
	
	private final String UP_DIR = "D:\\_javaweb\\_java\\fileUpload";
	
	public List<FileVO> uploadFiles(MultipartFile[] files){
		LocalDate date = LocalDate.now();
		log.info(">>> date : " + date);
		String today = date.toString(); // 오늘 날짜를 string 으로 변환 2022-12-27
		// - 를 파일 구분자(\)로 변경		ex) 2022-01-01 => 2022\01\01
		today = today.replace("-", File.separator);
		
		File folders = new File(UP_DIR, today); // new File(parent, child);
		
		// 폴더가 있으면 생성 X, 없으면 생성 O
		if(!folders.exists()) {
			folders.mkdirs(); // mkdirs : 디렉토리(폴더) 생성
		}
		// 파일 경로 설정 완료
		List<FileVO> fList = new ArrayList<FileVO>();
		for(MultipartFile file : files) {
			FileVO fvo = new FileVO();
			fvo.setSave_dir(today); // 파일 경로 설정
			fvo.setFile_size(file.getSize()); // 사이즈 설정
			
			String originalFileName = file.getOriginalFilename(); // 경로를 포함할수도 있는 파일명
			log.info(">>> fileName : " + originalFileName);
			
			String onlyFileName = originalFileName
					.substring(originalFileName.lastIndexOf("\\")+1); // 실제 파일명만 추출
			log.info(">>> only fileName : " + onlyFileName);
			fvo.setFile_name(onlyFileName); // 파일 이름 설정
			
			UUID uuid = UUID.randomUUID(); // UUID 형식
			fvo.setUuid(uuid.toString()); // uuid 설정, string 형식으로 바꿔줌
			
			// -------- 여기까지는 fvo 에 저장할 파일 정보 생성 -> set --------
			
			// 디스크에 저장할 파일 객체 생성
			String fullFileName = uuid.toString() + "_" + onlyFileName;
			File storeFile = new File(folders, fullFileName); // folders에 fullFileName 담아줌
			
			// IOException
			try {
				file.transferTo(storeFile); // 원본객체를 저장을 위한 형태로 복사
				if(isImageFile(storeFile)) { // 이미지라면
					fvo.setFile_type(1);
					File thumbNail = new File(folders, uuid.toString()+ "_th_" + onlyFileName);
					Thumbnails.of(storeFile).size(75, 75).toFile(thumbNail); // thumbNail 을 storeFile 경로로 (75,75) 사이즈로 파일을 만들어라
				}
			} catch (Exception e) {
				log.info(">>> File 생성 오류");
				e.printStackTrace();
			}
			fList.add(fvo); // for문 안에서 fList에 fvo 계속 추가
		}
		return fList;
	}
	
	public int deleteFile(FileVO fvo) {
		int isOk=0;
		File file = new File(UP_DIR+File.separator+fvo.getSave_dir()+File.separator+fvo.getUuid()+"_"+fvo.getFile_name());
		File tFile = new File(UP_DIR+File.separator+fvo.getSave_dir()+File.separator+fvo.getUuid()+"_th_"+fvo.getFile_name());
		try {
			
			if(file.exists()) {
				if(file.delete()) {
					log.info("삭제되었습니다.");
					isOk = 1;
				}else {
					log.info("삭제 실패");
				}
			}else {
				log.info("파일이 없습니다.");
			}
			
			if(tFile.exists()) {
				if(tFile.delete()) {
					log.info("썸네일 삭제되었습니다.");
					isOk = 1;
				}else {
					log.info("썸네일 삭제 실패");
				}
			}else {
				log.info("썸네일 파일이 없습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return isOk;
	}
	
	// image 인지 아닌지 체크 (tika)
	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile); // mimeType ===> image/png, image/jpg
		return mimeType.startsWith("image") ? true : false ;
	}

}
