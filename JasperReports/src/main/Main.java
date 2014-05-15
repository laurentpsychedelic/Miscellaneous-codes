package main;

import data.DataBean;
import data.DataBeanList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRXlsExporter;

public class Main {
    @SuppressWarnings("unchecked")
    public static void main(String[] args) {
        final String sourceFileName = "jasper_report_template.jasper";
        String printFileName = null;
        DataBeanList DataBeanList = new DataBeanList();
        ArrayList<DataBean> dataList = DataBeanList.getDataBeanList();

        JRBeanCollectionDataSource beanColDataSource =
            new JRBeanCollectionDataSource(dataList);

        Map parameters = new HashMap();
        parameters.put("ReportTitle", "List of Contacts");
        parameters.put("Author", "Prepared By Laurent F.");
        try {
            printFileName = JasperFillManager.fillReportToFile(sourceFileName,
                                                               parameters,
                                                               beanColDataSource);
            if (printFileName != null) {
                /** 1- export to PDF */
                JasperExportManager.exportReportToPdfFile(printFileName, "sample_report.pdf");
                /** 2- export to HTML */
                JasperExportManager.exportReportToHtmlFile(printFileName, "sample_report.html");
                /** 3- export to Excel sheet */
                JRXlsExporter exporter = new JRXlsExporter();

                exporter.setParameter(JRExporterParameter.INPUT_FILE_NAME,
                                      printFileName);
                exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, "sample_report.xls");

                exporter.exportReport();
            }
            if (printFileName != null)
                JasperPrintManager.printReport(printFileName, true);
        } catch (JRException e) {
            e.printStackTrace();
        }
    }
}
