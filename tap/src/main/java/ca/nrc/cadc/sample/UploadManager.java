package ca.nrc.cadc.sample;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.channels.Channels;

import org.apache.log4j.Logger;
import org.apache.solr.s3.S3OutputStream;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

import ca.nrc.cadc.uws.server.RandomStringGenerator;
import ca.nrc.cadc.uws.web.InlineContentException;
import ca.nrc.cadc.uws.web.UWSInlineContentHandler;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Configuration;

public class UploadManager implements UWSInlineContentHandler {
    private static Logger log = Logger.getLogger(UploadManager.class);
    private static final String bucket = System.getProperty("gcs_bucket");
    private static final String bucketURL = System.getProperty("gcs_bucket_url");
    private static final String bucketType = System.getProperty("gcs_bucket_type");

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

        // Construct return URL based on bucket type
        URL retURL;
        if (bucketType.equals("S3")) {
            retURL = new URL(bucketURL + "/" + bucket + "/" + filename);
        } else {
            retURL = new URL(bucketURL + "/" + filename);
        }

        Content ret = new Content();
        ret.name = UWSInlineContentHandler.CONTENT_PARAM_REPLACE;
        ret.value = new UWSInlineContentHandler.ParameterReplacement(
            "param:" + name,
            retURL.toExternalForm()
        );
        return ret;
    }

    private OutputStream getOutputStream(String filename, String contentType) {
        if (bucketType.equals("S3")) {
            return getOutputStreamS3(filename);
        } else {
            return getOutputStreamGCS(filename, contentType);
        }
    }

    private OutputStream getOutputStreamS3(String filename) {
        S3Configuration config = S3Configuration.builder()
            .pathStyleAccessEnabled(true)
            .useArnRegionEnabled(true)
            .build();

        S3Client s3Client = S3Client.builder()
            .endpointOverride(getURI())
            .serviceConfiguration(config)
            .region(Region.US_WEST_2)
            .build();

        return new S3OutputStream(s3Client, filename, bucket);
    }

    private OutputStream getOutputStreamGCS(String filename, String contentType) {
        Storage storage = StorageOptions.getDefaultInstance().getService();
        BlobId blobId = BlobId.of(bucket, filename);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
            .setContentType("application/x-votable+xml")
            .build();
        Blob blob = storage.create(blobInfo);
        return Channels.newOutputStream(blob.writer());
    }

    private URI getURI() {
        try {
            return new URI(bucketURL);
        } catch (URISyntaxException e) {
            throw new IllegalArgumentException(
                "Invalid bucket URL in configuration: " + e.getMessage(),
                e
            );
        }
    }
}
