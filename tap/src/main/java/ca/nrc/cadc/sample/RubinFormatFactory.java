package ca.nrc.cadc.sample;

import ca.nrc.cadc.dali.util.Format;
import ca.nrc.cadc.tap.TapSelectItem;
import ca.nrc.cadc.tap.writer.format.PostgreSQLFormatFactory;
import org.apache.log4j.Logger;

import ca.nrc.cadc.sample.RubinURLFormat;


public class RubinFormatFactory extends PostgreSQLFormatFactory {

    private static Logger log = Logger.getLogger(RubinFormatFactory.class);

    public RubinFormatFactory() {
    	super();
    }

    @Override
    public Format<Object> getClobFormat(TapSelectItem columnDesc) {
        // function with CLOB argument
        if (columnDesc != null) {
            // oga.ObsCore
            if ("oga.ObsCore".equalsIgnoreCase(columnDesc.tableName)) {
                if ("access_url".equalsIgnoreCase(columnDesc.getColumnName())) {
                    return new RubinURLFormat();
                }
            }
        }

        return super.getClobFormat(columnDesc);
    }
}
