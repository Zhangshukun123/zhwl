import static zhwlzlxt_project.tp.xmaihh.serialport.SerialHelper.hexToByteArray;
import static zhwlzlxt_project.tp.xmaihh.serialport.utils.ByteUtil.ByteArrToHex;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import zhwlzlxt_project.tp.xmaihh.serialport.stick.AbsStickPackageHelper;
import zhwlzlxt_project.tp.xmaihh.serialport.stick.SpecifiedStickPackageHelper;
import zhwlzlxt_project.tp.xmaihh.serialport.utils.Crc16Util;

public class TextApplication {

    public static void main(String[] args) {

        String tl = "AB BA 91 00 00 00 00 00 00 00 00 00 00";


        AbsStickPackageHelper mStickPackageHelper = new SpecifiedStickPackageHelper(hexToByteArray("ABBA"));  // 默认不处理粘包，直接读取返回

//        byte[] heard = Crc16Util.getData(Arrays.asList(tl.split(" ")));
        byte[] heard = new byte[]{-85, -70, -111};
        byte[] heard1 = new byte[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58,-85, -70, -111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58};


        String bRec = ByteArrToHex(heard);

        System.out.println("main: bRec-->" + bRec);
        System.out.println("main: heard-->" + Arrays.toString(heard));
        System.out.println("main: heard-->" + heard.length);
        System.out.println("main: (hexTo-->" + Arrays.toString(hexToByteArray("ABBA")));


        List<byte[]> byteList = new ArrayList<>();


        try {
            for (int i = 0; i < 10; i++) {
                InputStream inputStream1 = new ByteArrayInputStream(heard1);
                byte[] execute1 = mStickPackageHelper.execute(inputStream1);
                byteList.add(execute1);
            }
            for (byte[] execute : byteList) {
                System.out.println("main: byteList-->" + Arrays.toString(execute));
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }


    }
}
