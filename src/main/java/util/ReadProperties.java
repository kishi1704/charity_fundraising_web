package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReadProperties {
	
	private static final String FILE_CONFIG = "config.properties";
	private static ReadProperties instance = null;
	private Properties properties = new Properties();
	
	/**
	 * 
	 * @return instance of ReadProperties Object
	 */
	public static ReadProperties getInstance() {
		if(instance == null) {
			instance = new ReadProperties();
			instance.readConfig();
		}
		
		return instance;
	}
	
	/**
	 * get property with key
	 * @return value of key
	 */
	public String getProperty(String key) {
		return properties.getProperty(key);
	}
	
	/**
	 * read file .properties
	 */
	private void readConfig() {
		InputStream inputStream = null;
		try {
			inputStream = ReadProperties.class.getClassLoader()
					.getResourceAsStream(FILE_CONFIG);
			
			properties.load(inputStream);
		}catch(IOException e) {
			Logger.getLogger(ReadProperties.class.getName()).log(Level.SEVERE, null, e);
		}finally {
			try {
				if(inputStream != null) {
					inputStream.close();
				}
			}catch (IOException e) {
				Logger.getLogger(ReadProperties.class.getName()).log(Level.SEVERE, null, e);
			}
		}
	}
}
