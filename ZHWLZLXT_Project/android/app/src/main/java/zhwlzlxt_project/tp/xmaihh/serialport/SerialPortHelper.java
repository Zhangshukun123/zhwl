package zhwlzlxt_project.tp.xmaihh.serialport;

import zhwlzlxt_project.tp.xmaihh.serialport.bean.ComBean;

public class SerialPortHelper extends SerialHelper {



    public SerialPortHelper() {
        super("/dev/ttyS1", 9600);
    }

    @Override
    protected void onDataReceived(ComBean paramComBean) {

    }
}
