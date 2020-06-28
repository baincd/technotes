import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

public class ReadFileAsStringUtil {

	private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;

	public static File classpathFile(String pathRelativeToClasspath) throws URISyntaxException {
		URI filePathUri = ReadFileUtil.class.getClassLoader().getResource(pathRelativeToClasspath).toURI();
		return new File(filePathUri);
	}

	public static String readFileToString(File file) throws FileNotFoundException, IOException {
		try ( FileReader reader = new FileReader(file) ) {
			StringBuilder sb = new StringBuilder();
			char[] inBuf = new char[DEFAULT_BUFFER_SIZE];
			int inBufCount;
			while ( (inBufCount = reader.read(inBuf)) != -1) {
				sb.append(inBuf,0,inBufCount);
			}
			return sb.toString();
		}
	}

}
