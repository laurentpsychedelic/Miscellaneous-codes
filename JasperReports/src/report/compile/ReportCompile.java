package report.compile;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;

public class ReportCompile {
    public static void compile(final String sourceFileName) throws JRException {
        System.out.println("Compiling Report Design ...");
        try {
            JasperCompileManager.compileReportToFile(sourceFileName);
        } catch (JRException e) {
            e.printStackTrace();
            throw e;
        }
        System.out.println("Done compiling!!! ...");
    }
    public static void main(String[] args) {
        try {
            compile("jasper_report_template.jrxml");
        } catch (JRException e) {
            e.printStackTrace();
        }
    }
}
