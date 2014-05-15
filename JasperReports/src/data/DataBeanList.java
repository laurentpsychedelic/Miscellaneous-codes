package data;

import java.util.ArrayList;

public class DataBeanList {
    public ArrayList<DataBean> getDataBeanList() {
        ArrayList<DataBean> dataBeanList = new ArrayList<DataBean>();

        dataBeanList.add(produce("Nontan", "Japan"));
        dataBeanList.add(produce("Kame-san", "Ryuuguujou"));
        dataBeanList.add(produce("DJ Masterflex", "England"));
        dataBeanList.add(produce("La reine d'Angleterre", "Buckingham palace"));

        return dataBeanList;
    }

    /**
     * This method returns a DataBean object,
     * with name and country set in it.
     */
    private DataBean produce(String name, String country) {
        DataBean dataBean = new DataBean();
        dataBean.setName(name);
        dataBean.setCountry(country);
        return dataBean;
    }
}
