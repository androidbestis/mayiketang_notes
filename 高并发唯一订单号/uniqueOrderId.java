package com.adonai.test;

import sun.management.VMManagement;

import javax.xml.bind.DatatypeConverter;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;

/**
 * 生成唯一订单ID
 */
public class uniqueOrderId {

   public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException, NoSuchMethodException, InvocationTargetException, UnknownHostException, SocketException {
       //java 获取线程 ID
       long threadid = Thread.currentThread().getId();
       System.out.println("线程ID:" + threadid);

       //java获取进程ID
       RuntimeMXBean runtime = ManagementFactory.getRuntimeMXBean();
       Field jvm = runtime.getClass().getDeclaredField("jvm");
       jvm.setAccessible(true);
       VMManagement mgmt = (VMManagement)jvm.get(runtime);
       Method pidMethod = mgmt.getClass().getDeclaredMethod("getProcessId");
       pidMethod.setAccessible(true);
       int pid = (Integer) pidMethod.invoke(mgmt);
       System.out.println("进程ID: " + pid);

       //java 获取 mac 地址
       InetAddress localHost = InetAddress.getLocalHost();
       byte[] mac = NetworkInterface.getByInetAddress(localHost).getHardwareAddress();
       String macStr = DatatypeConverter.printHexBinary(mac);
       System.out.println("mac地址: " + macStr);
   }

}
