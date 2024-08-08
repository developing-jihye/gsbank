package common.utils.kdtfilemng;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


/**
 * 
* @packageName    : common.utils.kdtfilemng
* @fileName       : KdtFileMng.java
* @author         : 이의찬/매니저
* @date           : 2024.07.22
* @description    : 단일파일 업로드 예제입니다. 업로드 경로를 환경에 맞게 변경하셔야합니다.
* ===========================================================
* DATE           AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.07.22    이의찬/매니저          최초 생성
 */
@Service
public class KdtFileMng {

	public String singFileMng(MultipartHttpServletRequest fileRequest) {
		
		 String rootUploadDir = "C:"+File.separator+"Upload"; // C:/Upload
	        
	        File dir = new File(rootUploadDir + File.separator + "testfile"); 
	        
	        if(!dir.exists()) { //업로드 디렉토리가 존재하지 않으면 생성
	            dir.mkdirs();
	        }
	        
	        Iterator<String> iterator = fileRequest.getFileNames(); //업로드된 파일정보 수집(2개 - file1,file2)
	        
	        int fileLoop = 0;
	        String uploadFileName;
	        MultipartFile mFile = null;
	        String orgFileName = ""; //진짜 파일명
	        String sysFileName = ""; //변환된 파일명
	        
	        ArrayList<String> list = new ArrayList<String>();
	        
	        while(iterator.hasNext()) {
	            fileLoop++;
	            
	            uploadFileName = iterator.next();
	            mFile = fileRequest.getFile(uploadFileName);
	            
	            orgFileName = mFile.getOriginalFilename();    
	            System.out.println(orgFileName);
	            
	            if(orgFileName != null && orgFileName.length() != 0) { //sysFileName 생성
	                System.out.println("if문 진입");
	                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMDDHHmmss-" + fileLoop);
	                Calendar calendar = Calendar.getInstance();
	                sysFileName = simpleDateFormat.format(calendar.getTime()); //sysFileName: 날짜-fileLoop번호
	                
	                
	                try {
	                    System.out.println("try 진입");
	                    mFile.transferTo(new File(dir + File.separator + sysFileName)); // C:/Upload/testfile/sysFileName
	                    list.add("원본파일명: " + orgFileName + ", 시스템파일명: " + sysFileName);
	                    
	                }catch(Exception e){
	                    list.add("파일 업로드 중 에러발생!!!");
	                }
	                
	               
	            }//if
	        }//while
		
	    String filePath = dir + File.separator + sysFileName;
	    
		return filePath;
	}
	
}
