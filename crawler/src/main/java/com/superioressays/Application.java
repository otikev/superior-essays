package com.superioressays;

import com.superioressays.sweetStudy.Crawler;
import com.superioressays.sweetStudy.Network;

import java.io.IOException;
import java.util.Scanner;
import java.util.Timer;

/**
 * Created by otikev on 05-Jul-2022
 */

public class Application {

    public static void main(String[] args) {

        try {
            Network.notifyStart(getHostName());

            Crawler crawler = new Crawler();
            crawler.start(getHostName());

            while (true) {
            }//Do not terminate app
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getHostName() {
        try {
            String hostname = "unknown";
            String os = System.getProperty("os.name").toLowerCase();

            if (os.contains("win")) {
                //System.out.println("Windows computer name through env:\"" + System.getenv("COMPUTERNAME") + "\"");
                System.out.println("Windows computer name through exec:\"" + execReadToString("hostname") + "\"");
                hostname = execReadToString("hostname");
            } else if (os.contains("nix") || os.contains("nux") || os.contains("mac os x")) {
                //System.out.println("Unix-like computer name through env:\"" + System.getenv("HOSTNAME") + "\"");
                //System.out.println("Unix-like computer name through exec:\"" + execReadToString("hostname") + "\"");
                System.out.println("Unix-like computer name through /etc/hostname:\"" + execReadToString("cat /etc/hostname") + "\"");
                hostname = execReadToString("cat /etc/hostname");
            }
            return hostname;
        } catch (Exception e) {
            e.printStackTrace();
            return "unknown";
        }
    }

    public static String execReadToString(String execCommand) throws IOException {
        try (Scanner s = new Scanner(Runtime.getRuntime().exec(execCommand).getInputStream()).useDelimiter("\\A")) {
            return s.hasNext() ? s.next() : "";
        }
    }
}