package ca.nrc.cadc.sample;

import org.apache.log4j.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * A servlet that handles redirecting to specific job results.
 * This servlet extracts the VOTable file name from the request path and constructs a URL to redirect the client.
 *
 * @author stvoutsin
 */
public class ResultsServlet extends HttpServlet {
    private static final Logger log = Logger.getLogger(ResultsServlet.class);
    private static final String bucketURL = System.getProperty("gcs_bucket_url");

    /**
     * Processes GET requests by extracting the result filename from the request path and redirecting to the corresponding results URL.
     * The filename is assumed to be the path info of the request URL, following the first '/' character.
     *
     * @param request  the HttpServletRequest object that contains the request
     * @param response the HttpServletResponse object that contains the response
     * @throws ServletException if an input or output error is detected when the servlet handles the GET request
     * @throws IOException if the request for the GET could not be handled
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        String resultsFile  = path.substring(1);
        String redirectUrl = bucketURL + "/" + resultsFile;
        log.debug("Redirect URL: " + redirectUrl);
        response.sendRedirect(redirectUrl);
    }
}
