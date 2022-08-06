package com.superioressays;

import com.superioressays.sweetStudy.Crawler;
import com.superioressays.sweetStudy.Network;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Scanner;

/**
 * Created by otikev on 05-Jul-2022
 */

public class Application {
    private static final Logger logger = Logger.getLogger(Application.class);

    public static void main(String[] args) {

        try {
            Network.notifyStart(getHostName());

            Crawler crawler = new Crawler();
            crawler.start(getHostName());

            while (true) {
            }//Do not terminate app
        } catch (Exception e) {
            logger.trace(e);
        }
    }

    public static String getHostName() {
        try {
            String hostname = "unknown";
            String os = System.getProperty("os.name").toLowerCase();

            if (os.contains("win")) {
                //System.out.println("Windows computer name through env:\"" + System.getenv("COMPUTERNAME") + "\"");
                hostname = execReadToString("hostname").trim();
                logger.info("Windows computer name through exec:\"" + hostname + "\"");
            } else if (os.contains("nix") || os.contains("nux") || os.contains("mac os x")) {
                //System.out.println("Unix-like computer name through env:\"" + System.getenv("HOSTNAME") + "\"");
                //System.out.println("Unix-like computer name through exec:\"" + execReadToString("hostname") + "\"");
                System.out.println("Unix-like computer name through /etc/hostname:\"" + execReadToString("cat /etc/hostname") + "\"");
                hostname = execReadToString("cat /etc/hostname").trim();
                logger.info("Unix-like computer name through /etc/hostname:\"" + hostname + "\"");
            }
            return hostname.trim();
        } catch (Exception e) {
            logger.trace(e);
            return "unknown";
        }
    }

    public static String execReadToString(String execCommand) throws IOException {
        try (Scanner s = new Scanner(Runtime.getRuntime().exec(execCommand).getInputStream()).useDelimiter("\\A")) {
            return s.hasNext() ? s.next() : "";
        }
    }
}