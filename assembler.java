import java.io.File;
import java.util.Scanner;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.StringBuilder; 
import java.util.*;

public class assembler {
    public static void main(String [] args) throws Exception { 
        File file = new File("C:\\Users\\felix\\Downloads\\hey.txt");
        Scanner sc = new Scanner(file); 

        File writeFile = new File("C:\\Users\\felix\\Downloads\\hey2.txt");
        BufferedWriter buff = new BufferedWriter(new FileWriter(writeFile));

        while (sc.hasNextLine()) {
            String str = sc.nextLine();
            System.out.println(str); 

            String machineCode = assembler.instrToBinary(str);

            buff.write(machineCode);
            buff.newLine();
        }         

        buff.close();
    }

    public static String instrToBinary(String instruction) {
        StringBuilder binary = new StringBuilder();

        if(instruction.contains("add") || instruction.contains("beq")) {   //ex: add R3, R1, R2
            binary.append("00");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(5)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(9)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);
            
            int rt = Integer.parseInt(Character.toString(instruction.charAt(13)));
            binaryStr = Integer.toBinaryString(rt);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            if(instruction.contains("add")) {
                binary.append("0");
            }
            else{
                binary.append("1");
            }
        }

        if(instruction.contains("sw") || instruction.contains("lw")) {   //ex: 
            binary.append("01");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(4)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(8)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            binary.append("0"); //BLANK
            
            if(instruction.contains("sw")) {
                binary.append("00");
            }
            else{
                binary.append("01");
            }
        }

        //add here
        if(instruction.contains("slt")) {   //ex: 
            binary.append("01");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(5)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(9)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr); 

            int rt = Integer.parseInt(Character.toString(instruction.charAt(13)));
            binaryStr = Integer.toBinaryString(rt);
            binary.append(binaryStr);   

            binary.append("10");        
        }


        if(instruction.contains("mv")) {
            binary.append("01");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(4)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(7)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "00" + binaryStr;
            }
            else if(binaryStr.length() == 2) {
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            binary.append("11");
        }

        if(instruction.contains("orr") || instruction.contains("sub")) {   //ex: add R3, R1, R2
            binary.append("10");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(5)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(9)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);
            
            int rt = Integer.parseInt(Character.toString(instruction.charAt(13)));
            binaryStr = Integer.toBinaryString(rt);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            if(instruction.contains("orr")) {
                binary.append("0");
            }
            else{
                binary.append("1");
            }
        }

        if(instruction.contains("sll") || instruction.contains("srl")) {   //ex: add R3, R1, R2
            binary.append("11");

            int rd = Integer.parseInt(Character.toString(instruction.charAt(5)));
            String binaryStr = Integer.toBinaryString(rd);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            int rs = Integer.parseInt(Character.toString(instruction.charAt(9)));
            binaryStr = Integer.toBinaryString(rs);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);
            
            int rt = Integer.parseInt(Character.toString(instruction.charAt(13)));
            binaryStr = Integer.toBinaryString(rt);
            if(binaryStr.length() == 1) { //pad with 0
                binaryStr = "0" + binaryStr;
            }
            binary.append(binaryStr);

            if(instruction.contains("sll")) {
                binary.append("0");
            }
            else{
                binary.append("1");
            }
        }

        return binary.toString();

    } 

}