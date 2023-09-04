package zhwlzlxt_project.tp.xmaihh.serialport.utils;

import android.util.Log;

import java.util.List;


/**
 * * ━━━━━━神兽保佑━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛
 * 　　　　┃　　　┃
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 * ━━━━━━代码无bug━━━━━━
 *
 * @author LD
 * @date 2018/7/18
 * 基于Modbus CRC16的校验算法工具类
 */
public class Crc16Util {




    /**
     * 获取源数据和验证码的组合byte数组
     *
     * @param strings 可变长度的十六进制字符串
     * @return
     */
    public static byte[] getData(List<String> strings) {
        byte[] data = new byte[]{};
        for (int i = 0; i < strings.size(); i++) {
            int x = Integer.parseInt(strings.get(i), 16);
            byte n = (byte) x;
            byte[] buffer = new byte[data.length + 1];
            byte[] aa = {n};
            System.arraycopy(data, 0, buffer, 0, data.length);
            System.arraycopy(aa, 0, buffer, data.length, aa.length);
            data = buffer;
        }
        return getDataB(data);
    }

    /**
     * 获取源数据组合byte数组
     *
     * @param strings 可变长度的十六进制字符串
     * @return
     */
    public static byte[] getDataNoCrc(String... strings) {
        byte[] data = new byte[]{};
        for (int i = 0; i < strings.length; i++) {
            int x = Integer.parseInt(strings[i], 16);
            byte n = (byte) x;
            byte[] buffer = new byte[data.length + 1];
            byte[] aa = {n};
            System.arraycopy(data, 0, buffer, 0, data.length);
            System.arraycopy(aa, 0, buffer, data.length, aa.length);
            data = buffer;
        }

        return data;
    }

    /**
     * 拼接数组
     *
     * @param aa 字节数组
     * @return
     */
    public static byte[] spellData(byte[] aa, byte[] bb) {
        byte[] cc = new byte[aa.length + bb.length];
        System.arraycopy(aa, 0, cc, 0, aa.length);
        System.arraycopy(bb, 0, cc, aa.length, bb.length);
        return cc;
    }

    /**
     * 获取源数据和验证码的组合byte数组
     * 拼接数组
     *
     * @param aa 字节数组
     * @return
     */
    private static byte[] getData(byte[] aa) {
        byte[] bb = getCrc16(aa);
        byte[] cc = new byte[aa.length + bb.length];
        System.arraycopy(aa, 0, cc, 0, aa.length);
        System.arraycopy(bb, 0, cc, aa.length, bb.length);
        return cc;
    }


    /**
     * 获取源数据和
     * 求和验证码
     * 的组合byte数组
     *
     * @param aa 字节数组
     * @return
     */
    public static byte[] getDataB(byte[] aa) {

//        String str = byteTo16String(aa);
//
//        ;
        String hex = makeCRC(aa);
        byte[] bb = getDataNoCrc(hex);
        byte[] cc = new byte[aa.length + bb.length];
        System.arraycopy(aa, 0, cc, 0, aa.length);
        System.arraycopy(bb, 0, cc, aa.length, bb.length);
        return cc;
    }

    /**
     * 获取验证码byte数组，基于Modbus CRC16的校验算法
     */
    private static byte[] getCrc16(byte[] arr_buff) {
        int len = arr_buff.length;

        // 预置 1 个 16 位的寄存器为十六进制FFFF, 称此寄存器为 CRC寄存器。
        int crc = 0xFFFF;
        int i, j;
        for (i = 0; i < len; i++) {
            // 把第一个 8 位二进制数据 与 16 位的 CRC寄存器的低 8 位相异或, 把结果放于 CRC寄存器
            crc = ((crc & 0xFF00) | (crc & 0x00FF) ^ (arr_buff[i] & 0xFF));
            for (j = 0; j < 8; j++) {
                // 把 CRC 寄存器的内容右移一位( 朝低位)用 0 填补最高位, 并检查右移后的移出位
                if ((crc & 0x0001) > 0) {
                    // 如果移出位为 1, CRC寄存器与多项式A001进行异或
                    crc = crc >> 1;
                    crc = crc ^ 0xA001;
                } else
                    // 如果移出位为 0,再次右移一位
                    crc = crc >> 1;
            }
        }
        return intToBytes(crc);

    }


    /**
     * 将int转换成byte数组，低位在前，高位在后
     * 改变高低位顺序只需调换数组序号
     */
    private static byte[] intToBytes(int value) {
        byte[] src = new byte[2];
        src[1] = (byte) ((value >> 8) & 0xFF);
        src[0] = (byte) (value & 0xFF);
        return src;
    }


    /**
     * 将字节数组转换成十六进制字符串
     */
    public static String byteTo16String(byte[] data) {
        StringBuffer buffer = new StringBuffer();
        for (byte b : data) {
            buffer.append(byteTo16String(b));
        }
        return buffer.toString();
    }

    /**
     * 将字节转换成十六进制字符串
     * int转byte对照表
     * [128,255],0,[1,128)
     * [-128,-1],0,[1,128)
     */
    public static String byteTo16String(byte b) {
        StringBuffer buffer = new StringBuffer();
        int aa = (int) b;
        if (aa < 0) {
            buffer.append(Integer.toString(aa + 256, 16) + " ");
        } else if (aa == 0) {
            buffer.append("00 ");
        } else if (aa > 0 && aa <= 15) {
            buffer.append("0" + Integer.toString(aa, 16) + " ");
        } else if (aa > 15) {
            buffer.append(Integer.toString(aa, 16) + " ");
        }
        return buffer.toString();
    }


    /**
     * 累加校验和
     * 取低字节
     **/
    public static String makeChecksum(String data) {
        if (data == null || data.equals("")) {
            return "";
        }
        int total = 0;
        int len = data.length();
        int num = 0;
        while (num < len) {
            String s = data.substring(num, num + 2);
            total += Integer.parseInt(s, 16);
            num = num + 3;
        }
        //用256求余最大是255，即16进制的FF
        int mod = total % 256;
        String hex = Integer.toHexString(mod);
        Log.i("TAG", "onMethodCall: --->"+hex);

        len = hex.length();
// 如果不够校验位的长度，补0,这里用的是两位校验
        if (len < 2) {
            hex = "0" + hex;
        }
        return hex;
    }


    /**
     * 十六转二进制
     *
     * @param hex 十六进制字符串
     * @return 二进制字符串
     */
    public static String hexStringToBinary(String hex) {
        hex = hex.toUpperCase();
        String result = "";
        int max = hex.length();
        for (int i = 0; i < max; i++) {
            char c = hex.charAt(i);
            switch (c) {
                case '0':
                    result += "0000";
                    break;
                case '1':
                    result += "0001";
                    break;
                case '2':
                    result += "0010";
                    break;
                case '3':
                    result += "0011";
                    break;
                case '4':
                    result += "0100";
                    break;
                case '5':
                    result += "0101";
                    break;
                case '6':
                    result += "0110";
                    break;
                case '7':
                    result += "0111";
                    break;
                case '8':
                    result += "1000";
                    break;
                case '9':
                    result += "1001";
                    break;
                case 'A':
                    result += "1010";
                    break;
                case 'B':
                    result += "1011";
                    break;
                case 'C':
                    result += "1100";
                    break;
                case 'D':
                    result += "1101";
                    break;
                case 'E':
                    result += "1110";
                    break;
                case 'F':
                    result += "1111";
                    break;
            }
        }
        //字符串反转
        StringBuffer buf = new StringBuffer(result);
        buf = buf.reverse();
        result = buf.toString();
        return result;
    }

//    public static void main(String[] args) {
//        byte[] dd = Crc16Util.getData("01", "01", "00", "00", "00", "00");
//        System.out.println(Crc16Util.byteTo16String(dd).toUpperCase());
//    }




    public static String makeCRC(byte[] bytes) {
        int crc = 0x0000ffff;
        for (byte aByte : bytes) {
            crc ^= ((int) aByte & 0x000000ff);
            for (int j = 0; j < 8; j++) {
                if ((crc & 0x00000001) != 0) {
                    crc >>= 1;
                    crc ^= 0x0000a001;
                } else {
                    crc >>= 1;
                }
            }
        }
        // 高低位互换，输出符合相关工具对Modbus CRC16的运算
//        crc = ((crc & 0xff00) >> 8) | ((crc & 0x00ff) << 8);


        Log.i("TAG", "onMethodCall--makeCRC: "+String.format("%04X", crc));

        return String.format("%04X", crc);
    }


    public static int crc16(byte[] data) {
        int crc = 0xFFFF;
        int polynomial = 0x1021;
        for (byte b : data) {
            for (int i = 0; i < 8; i++) {
                boolean bit = ((b >> (7 - i) & 1) == 1);
                boolean c15 = ((crc >> 15 & 1) == 1);
                crc <<= 1;
                if (c15 ^ bit) {
                    crc ^= polynomial;
                }
            }
        }
        crc &= 0xffff;


        return crc;
    }


    /**
     * 查表法计算CRC16校验
     *
     * @param data 需要计算的字节数组
     */
    public static String getCRC(byte[] data) {
        byte[] crc16_h = {
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41,
                (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x01, (byte) 0xC0, (byte) 0x80, (byte) 0x41, (byte) 0x00, (byte) 0xC1, (byte) 0x81, (byte) 0x40
        };

        byte[] crc16_l = {
                (byte) 0x00, (byte) 0xC0, (byte) 0xC1, (byte) 0x01, (byte) 0xC3, (byte) 0x03, (byte) 0x02, (byte) 0xC2, (byte) 0xC6, (byte) 0x06, (byte) 0x07, (byte) 0xC7, (byte) 0x05, (byte) 0xC5, (byte) 0xC4, (byte) 0x04,
                (byte) 0xCC, (byte) 0x0C, (byte) 0x0D, (byte) 0xCD, (byte) 0x0F, (byte) 0xCF, (byte) 0xCE, (byte) 0x0E, (byte) 0x0A, (byte) 0xCA, (byte) 0xCB, (byte) 0x0B, (byte) 0xC9, (byte) 0x09, (byte) 0x08, (byte) 0xC8,
                (byte) 0xD8, (byte) 0x18, (byte) 0x19, (byte) 0xD9, (byte) 0x1B, (byte) 0xDB, (byte) 0xDA, (byte) 0x1A, (byte) 0x1E, (byte) 0xDE, (byte) 0xDF, (byte) 0x1F, (byte) 0xDD, (byte) 0x1D, (byte) 0x1C, (byte) 0xDC,
                (byte) 0x14, (byte) 0xD4, (byte) 0xD5, (byte) 0x15, (byte) 0xD7, (byte) 0x17, (byte) 0x16, (byte) 0xD6, (byte) 0xD2, (byte) 0x12, (byte) 0x13, (byte) 0xD3, (byte) 0x11, (byte) 0xD1, (byte) 0xD0, (byte) 0x10,
                (byte) 0xF0, (byte) 0x30, (byte) 0x31, (byte) 0xF1, (byte) 0x33, (byte) 0xF3, (byte) 0xF2, (byte) 0x32, (byte) 0x36, (byte) 0xF6, (byte) 0xF7, (byte) 0x37, (byte) 0xF5, (byte) 0x35, (byte) 0x34, (byte) 0xF4,
                (byte) 0x3C, (byte) 0xFC, (byte) 0xFD, (byte) 0x3D, (byte) 0xFF, (byte) 0x3F, (byte) 0x3E, (byte) 0xFE, (byte) 0xFA, (byte) 0x3A, (byte) 0x3B, (byte) 0xFB, (byte) 0x39, (byte) 0xF9, (byte) 0xF8, (byte) 0x38,
                (byte) 0x28, (byte) 0xE8, (byte) 0xE9, (byte) 0x29, (byte) 0xEB, (byte) 0x2B, (byte) 0x2A, (byte) 0xEA, (byte) 0xEE, (byte) 0x2E, (byte) 0x2F, (byte) 0xEF, (byte) 0x2D, (byte) 0xED, (byte) 0xEC, (byte) 0x2C,
                (byte) 0xE4, (byte) 0x24, (byte) 0x25, (byte) 0xE5, (byte) 0x27, (byte) 0xE7, (byte) 0xE6, (byte) 0x26, (byte) 0x22, (byte) 0xE2, (byte) 0xE3, (byte) 0x23, (byte) 0xE1, (byte) 0x21, (byte) 0x20, (byte) 0xE0,
                (byte) 0xA0, (byte) 0x60, (byte) 0x61, (byte) 0xA1, (byte) 0x63, (byte) 0xA3, (byte) 0xA2, (byte) 0x62, (byte) 0x66, (byte) 0xA6, (byte) 0xA7, (byte) 0x67, (byte) 0xA5, (byte) 0x65, (byte) 0x64, (byte) 0xA4,
                (byte) 0x6C, (byte) 0xAC, (byte) 0xAD, (byte) 0x6D, (byte) 0xAF, (byte) 0x6F, (byte) 0x6E, (byte) 0xAE, (byte) 0xAA, (byte) 0x6A, (byte) 0x6B, (byte) 0xAB, (byte) 0x69, (byte) 0xA9, (byte) 0xA8, (byte) 0x68,
                (byte) 0x78, (byte) 0xB8, (byte) 0xB9, (byte) 0x79, (byte) 0xBB, (byte) 0x7B, (byte) 0x7A, (byte) 0xBA, (byte) 0xBE, (byte) 0x7E, (byte) 0x7F, (byte) 0xBF, (byte) 0x7D, (byte) 0xBD, (byte) 0xBC, (byte) 0x7C,
                (byte) 0xB4, (byte) 0x74, (byte) 0x75, (byte) 0xB5, (byte) 0x77, (byte) 0xB7, (byte) 0xB6, (byte) 0x76, (byte) 0x72, (byte) 0xB2, (byte) 0xB3, (byte) 0x73, (byte) 0xB1, (byte) 0x71, (byte) 0x70, (byte) 0xB0,
                (byte) 0x50, (byte) 0x90, (byte) 0x91, (byte) 0x51, (byte) 0x93, (byte) 0x53, (byte) 0x52, (byte) 0x92, (byte) 0x96, (byte) 0x56, (byte) 0x57, (byte) 0x97, (byte) 0x55, (byte) 0x95, (byte) 0x94, (byte) 0x54,
                (byte) 0x9C, (byte) 0x5C, (byte) 0x5D, (byte) 0x9D, (byte) 0x5F, (byte) 0x9F, (byte) 0x9E, (byte) 0x5E, (byte) 0x5A, (byte) 0x9A, (byte) 0x9B, (byte) 0x5B, (byte) 0x99, (byte) 0x59, (byte) 0x58, (byte) 0x98,
                (byte) 0x88, (byte) 0x48, (byte) 0x49, (byte) 0x89, (byte) 0x4B, (byte) 0x8B, (byte) 0x8A, (byte) 0x4A, (byte) 0x4E, (byte) 0x8E, (byte) 0x8F, (byte) 0x4F, (byte) 0x8D, (byte) 0x4D, (byte) 0x4C, (byte) 0x8C,
                (byte) 0x44, (byte) 0x84, (byte) 0x85, (byte) 0x45, (byte) 0x87, (byte) 0x47, (byte) 0x46, (byte) 0x86, (byte) 0x82, (byte) 0x42, (byte) 0x43, (byte) 0x83, (byte) 0x41, (byte) 0x81, (byte) 0x80, (byte) 0x40
        };

        int crc = 0x0000ffff;
        int ucCRCHi = 0x00ff;
        int ucCRCLo = 0x00ff;
        int iIndex;
        for (byte datum : data) {
            iIndex = (ucCRCLo ^ datum) & 0x00ff;
            ucCRCLo = ucCRCHi ^ crc16_h[iIndex];
            ucCRCHi = crc16_l[iIndex];
        }
        crc = ((ucCRCHi & 0x00ff) << 8) | (ucCRCLo & 0x00ff) & 0xffff;
//        crc = ((crc & 0xFF00) >> 8) | ((crc & 0x00FF) << 8);
        String format = String.format("%04X", crc);

        if (format.length() != 4) {
            return "";
        }
        return format.substring(0, 2) + " " + format.substring(2, 4);
    }


}