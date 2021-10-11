package com.techblog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	//to delete file
	public static boolean deleteFile(String path)
	{
		boolean f=false;
		
		try {
			
			File file = new File(path);
			f = file.delete();
						
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return f;
	}
	
	//to create file
	public static boolean saveFile(InputStream is, String path)
	{
		boolean f=false;
		
		try {
			byte b[] = new byte[is.available()];
			is.read(b);
			
			//to write file into path
			FileOutputStream fos = new FileOutputStream(path);
			fos.write(b);
			fos.flush();
			fos.close();
			
			f=true;
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return f;
	}
}
