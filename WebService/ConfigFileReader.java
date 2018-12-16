package dataProvider;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class ConfigFileReader {
	
	private Properties properties;
	private final String propertyFilePath = "config/Configuration.properties";
	
	public ConfigFileReader(){
		BufferedReader reader;
		try {
			reader = new BufferedReader(new FileReader(propertyFilePath));
			properties = new Properties();
			try {
				properties.load(reader);
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("Configuration.properties not found at " + propertyFilePath);
		}		
	}
	
	public String getApplicationUrl() {
		String url = properties.getProperty("customUrl");
		if(url != null) return url;
		else throw new RuntimeException("url not specified in the Configuration.properties file.");
	}

	public String getUserName(){
		String sfUserName = properties.getProperty("sfUserName");
		if(sfUserName != null) return sfUserName;
		else throw new RuntimeException("UserName not specified in the Configuration.properties file");		
	}
	
	public String getClientId(){
		String clientId = properties.getProperty("clientId");
		if(clientId != null) return clientId;
		else throw new RuntimeException("ClientId not specified in the Configuration.properties file");		
	}
	
	public String getClientSecretKey(){
		String clientSecret = properties.getProperty("clientSecret");
		if(clientSecret != null) return clientSecret;
		else throw new RuntimeException("ClientSecret not specified in the Configuration.properties file");		
	}
	
	public String getUserPassword(){
		String sfPassword = properties.getProperty("sfPassword");
		if(sfPassword != null) return sfPassword;
		else throw new RuntimeException("UserName not specified in the Configuration.properties file");		
	}
}