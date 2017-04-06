package com.mdl.mdlrestapi.psm.utils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.net.URISyntaxException;
import java.net.URL;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.IOUtils;
import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.xml.sax.SAXException;

import com.mdl.mdlrestapi.psm.exception.ApacheFopException;
import com.mdl.mdlrestapi.psm.service.impl.ReportServiceImpl;

/**
 * @Author	: Rushan
 * @Date	: Mar 26, 2017
 * @TIme	: 11:59:13 AM
 */
public class GeneratePDFBiteArray {

	/** The MSG_CREATING_PDF_ERROR. */
	private static final String MSG_CREATING_PDF_ERROR = "Error creating PDF, details=%s";
	/** The Constant FOP_CONFIG_FILE. */
	private static final String FOP_CONFIG_FILE = "fop.xconf";
	/** The HEADER_FILE. */
	private static final String HEADER_FILE = "header-footer.xsl";
	
	
	/**
	 * Creates the pdf.
	 *
	 * @param xml the xml
	 * @param xsltFilename the xslt file name
	 * @return the byte[]
	 */
	public static byte[] createPdf(String xml, String xsltFilename) {

		byte[] byteArray = null;
		ByteArrayOutputStream outStream = null;

		try {
			Source xmlSource = getXmlSource(xml);
			Source xsltSource = getXmlSource(getXMLString(xsltFilename));

			/**
			 *  Create an instance of fop factory
			 */
			FopFactory fopFactory = FopFactory.newInstance(getConfigFile());

			/**
			 *  Create the output stream
			 */
			outStream = new ByteArrayOutputStream();

			/**
			 *  Create transformer from TransformerFactory
			 */
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			transformerFactory.setURIResolver(new MyResolver(getXMLString(HEADER_FILE)));
			Transformer xslfoTransformer = transformerFactory.newTransformer(xsltSource);

			/**
			 *  Construct fop with desired output format
			 */
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, outStream);

			/**
			 *  Resulting SAX events (the generated FO) must be piped through to FOP
			 */
			Result res = new SAXResult(fop.getDefaultHandler());

			/**
			 * Transform the xml to a pdf
			 */
			xslfoTransformer.transform(xmlSource, res);

			/**
			 * return the pdf bytes
			 */
			byteArray = outStream.toByteArray();

		} catch (TransformerConfigurationException e) {
			handleException(e);
		} catch (FOPException e) {
			handleException(e);
		} catch (TransformerException e) {
			handleException(e);
		} catch (SAXException e) {
			handleException(e);
		} catch (IOException e) {
			handleException(e);
		} catch (URISyntaxException e) {
			handleException(e);
		} finally {
			IOUtils.closeQuietly(outStream);
		}

		return byteArray;
	}

	
	//read from xml
	private static String getXMLString(String filename) throws IOException {
		
		URL url = ReportServiceImpl.class.getClassLoader().getResource(filename); 
		File file = new File(url.getPath());

		Reader fileReader = new FileReader(file);
		BufferedReader bufReader = new BufferedReader(fileReader); 
		StringBuilder sb = new StringBuilder(); 
		String line = bufReader.readLine(); 
		
		while( line != null){ 
			sb.append(line).append("\n"); 
			line = bufReader.readLine(); 
		} 
		String xml2String = sb.toString(); 
		bufReader.close();

		return xml2String;		
	}

	// ===========================================
	// Protected Methods
	// ===========================================

	// ===========================================
	// Private Methods
	// ===========================================

	/**
	 * Gets the config file.
	 *
	 * @return the config file
	 * @throws URISyntaxException the URI syntax exception
	 */
	private static File getConfigFile() throws URISyntaxException {
		URL url = ReportServiceImpl.class.getClassLoader().getResource(FOP_CONFIG_FILE);
		File file = new File(url.getPath());
		return file;
	}

	/**
	 * Gets the xml source.
	 *
	 * @param xml the xml
	 * @return the xml source
	 */
	private static StreamSource getXmlSource(final String xml) {
		return new StreamSource(new StringReader(xml));
	}

	/**
	 * Handle exception.
	 *
	 * @param e the e
	 */
	private static void handleException(Exception e) {
		System.out.println(e.getMessage());
		throw new ApacheFopException(String.format(MSG_CREATING_PDF_ERROR, e.getMessage()), e);
	}
}


/*
 * To handle imports in the xsl file
 * 
 * */
class MyResolver implements URIResolver {
    String xsltStr;

    public MyResolver(String xsltStr) {
      this.xsltStr = xsltStr;
    }

    public Source resolve(String href,String base) {

        return new StreamSource(new StringReader(this.xsltStr));
    }
  }


