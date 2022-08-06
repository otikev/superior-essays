package com.superioressays;

import com.superioressays.sweetStudy.Crawler;
import org.apache.log4j.Logger;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import static com.superioressays.Application.getHostName;

/**
 * Created by otikev on 06-Aug-2022
 */

public class Scheduler {
    private static final Logger logger = Logger.getLogger(Scheduler.class);
    private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public static void schedule() {

        ScheduledFuture<?> countdown = scheduler.schedule(new Runnable() {
            @Override
            public void run() {
                logger.info("***********************************");
                logger.info("**** Scheduled run executing ******");
                logger.info("***********************************");
                Crawler crawler = new Crawler();
                crawler.start(getHostName());
            }
        }, 6, TimeUnit.HOURS);
        logger.info("Scheduled next run");

        while (!countdown.isDone()) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                logger.error(e.getMessage(),e);
            }
        }
    }
}
