package util;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class FileAction {
public static String readFile(String fileName) throws FileNotFoundException {
	String content="";
	File file=new File(fileName);
	Scanner scanner=new Scanner(file);
	while(scanner.hasNextLine()) {
	content+=scanner.nextLine();
	}
	scanner.close();
	return content;
}
public static String readFile(File file) throws FileNotFoundException {
	String content="";
	Scanner scanner=new Scanner(file);
	while(scanner.hasNextLine()) {
	content+=scanner.nextLine();
	}
	scanner.close();
	return content;
}

}
