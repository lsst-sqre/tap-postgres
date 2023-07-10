package ca.nrc.cadc.sample;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.Channels;
import java.net.URL;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

import ca.nrc.cadc.uws.server.RandomStringGenerator;
import ca.nrc.cadc.uws.web.InlineContentException;
import ca.nrc.cadc.uws.web.UWSInlineContentHandler;

import org.apache.log4j.Logger;


public class UploadManager implements UWSInlineContentHandler {

    private static Logger log = Logger.getLogger(UploadManager.class);

    private static final String bucket = System.getProperty("gcs_bucket");
    private static final String bucketURL = System.getProperty("gcs_bucket_url");
    public UploadManager() {

    }

    @Override
    public Content accept(String name, String contentType, InputStream inputStream)
        throws InlineContentException, IOException {

	log.debug("name: " + name);
        log.debug("Content-Type: " + contentType);
        if (inputStream == null) {
            throw new IOException("InputStream cannot be null");
        }

	String filename = name + "-" + new RandomStringGenerator(16).getID();
	OutputStream os = getOutputStream(filename, contentType);

	byte[] buf = new byte[16384];
	int num = inputStream.read(buf);
	while (num > 0) {
            os.write(buf, 0, num);
            num = inputStream.read(buf);
        }
	os.flush();
	os.close();


        URL retURL = new URL(bucketURL + "/" + filename);

	Content ret = new Content();
	ret.name = UWSInlineContentHandler.CONTENT_PARAM_REPLACE;
	ret.value = new UWSInlineContentHandler.ParameterReplacement("param:" + name, retURL.toExternalForm());
	return ret;
    }

    private OutputStream getOutputStream(String filename, String contentType) {
        Storage storage = StorageOptions.getDefaultInstance().getService();
        BlobId blobId = BlobId.of(bucket, filename);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("application/x-votable+xml").build();
        Blob blob = storage.create(blobInfo);
        return Channels.newOutputStream(blob.writer());
    }
}
