package zhwlzlxt_project.tp.xmaihh.serialport;

import zhwlzlxt_project.tp.xmaihh.serialport.bean.ComBean;

public class SerialPortHelper extends SerialHelper {

    private onPortDataReceived received;

    public void setReceived(onPortDataReceived received) {
        this.received = received;
    }

    public SerialPortHelper() {
        super("/dev/ttyS1", 115200);
    }

    @Override
    protected void onDataReceived(ComBean paramComBean) {
        if (received!=null){
            received.onPortDataReceived(paramComBean);
        }
    }

    @Override
    protected void onStartError() {
        if (received!=null){
            received.onStartError();
        }
    }


    public interface onPortDataReceived {
        void onPortDataReceived(ComBean paramComBean);

        void onStartError();
    }
}
