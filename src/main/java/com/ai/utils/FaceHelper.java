package com.ai.utils;

import com.ai.model.DataResp;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
 
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.util.StringUtils;

import javax.net.ssl.SSLException;
import javax.xml.crypto.Data;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

/**
 * 人脸识别工具类
 * @author ma_yi
 * 个人博客 https://blog.csdn.net/qq_23412263
 */
public class FaceHelper {
    // 调用 API
    private static final String FACE_URL ="https://api-cn.faceplusplus.com/facepp/v3/";

    public static final String FACE_API_DETECT = "detect";
    public static final String FACE_API_COMPARE = "compare";

    // 你的 key
    public static final String API_KEY = "4M_R4ur9rUz-Z2_BWU7a87FBiksvVJF2";
    // 你的 SECRET
    private static final String API_SECRET = "fp-2BdC1oV2b1xxaW9uJtTBSAdR-jd9n";

    private final static int CONNECT_TIME_OUT = 30000;
    private final static int READ_OUT_TIME = 50000;
    private static String boundaryString = getBoundary();

    // 活体检测类型
    public static final String CHECK_TYPE_MOUTH = "mouth";
    public static final String CHECK_TYPE_EYE = "eye";

    // 嘴巴或眼睛状态
    private static final String STATUS_OPEN = "open";
    private static final String STATUS_CLOSE = "close";

    // 活体检测失败次数阈值，超过这个次数就认为检测失败，不再检测
    private static final int CHECK_FAILED_THRESHOLD = 10;

    // 记录检测失败次数的 key，和用户 id 一起组成唯一的 key
    private static final String KEY_FAILED_COUNT = "failedCount";

    // 存放张张嘴脸部对比数据的 map
    private static Map<String, Object> mouthCheckMap = new HashMap<>();
    // 存放眨眨眼脸部对比数据的 map
    private static Map<String, Object> eyeCheckMap = new HashMap<>();

    public static byte[] post(String api, HashMap<String, String> map, HashMap<String, byte[]> fileMap) throws Exception {
        HttpURLConnection conne;
        URL url1 = new URL(FACE_URL+api);
        conne = (HttpURLConnection) url1.openConnection();
        conne.setDoOutput(true);
        conne.setUseCaches(false);
        conne.setRequestMethod("POST");
        conne.setConnectTimeout(CONNECT_TIME_OUT);
        conne.setReadTimeout(READ_OUT_TIME);
        conne.setRequestProperty("accept", "*/*");
        conne.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundaryString);
        conne.setRequestProperty("connection", "Keep-Alive");
        conne.setRequestProperty("user-agent", "Mozilla/4.0 (compatible;MSIE 6.0;Windows NT 5.1;SV1)");
        DataOutputStream obos = new DataOutputStream(conne.getOutputStream());
        Iterator iter = map.entrySet().iterator();
        while (iter.hasNext()) {
            Map.Entry<String, String> entry = (Map.Entry) iter.next();
            String key = entry.getKey();
            String value = entry.getValue();
            obos.writeBytes("--" + boundaryString + "\r\n");
            obos.writeBytes("Content-Disposition: form-data; name=\"" + key
                    + "\"\r\n");
            obos.writeBytes("\r\n");
            obos.writeBytes(value + "\r\n");
        }
        if (fileMap != null && fileMap.size() > 0) {
            Iterator fileIter = fileMap.entrySet().iterator();
            while (fileIter.hasNext()) {
                Map.Entry<String, byte[]> fileEntry = (Map.Entry<String, byte[]>) fileIter.next();
                obos.writeBytes("--" + boundaryString + "\r\n");
                obos.writeBytes("Content-Disposition: form-data; name=\"" + fileEntry.getKey()
                        + "\"; filename=\"" + encode(" ") + "\"\r\n");
                obos.writeBytes("\r\n");
                obos.write(fileEntry.getValue());
                obos.writeBytes("\r\n");
            }
        }
        obos.writeBytes("--" + boundaryString + "--" + "\r\n");
        obos.writeBytes("\r\n");
        obos.flush();
        obos.close();
        InputStream ins = null;
        int code = conne.getResponseCode();
        try {
            if (code == 200) {
                ins = conne.getInputStream();
            } else {
                ins = conne.getErrorStream();
            }
        } catch (SSLException e) {
            e.printStackTrace();
            return new byte[0];
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buff = new byte[4096];
        int len;
        while ((len = ins.read(buff)) != -1) {
            baos.write(buff, 0, len);
        }
        byte[] bytes = baos.toByteArray();
        ins.close();
        return bytes;
    }

    private static String getBoundary() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 32; ++i) {
            sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-".charAt(random.nextInt("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_".length())));
        }
        return sb.toString();
    }

    private static String encode(String value) throws Exception {
        return URLEncoder.encode(value, "UTF-8");
    }

    /**
     * 人脸识别
     * @param imgBase64
     */
    public static DataResp faceDetect(String imgBase64) {
        HashMap<String, String> map = new HashMap<>();
        map.put("api_key", API_KEY); // 调用此API的API Key
        map.put("api_secret", API_SECRET); // 调用此API的API Secret
        map.put("return_landmark", "1"); // 是否检测并返回人脸关键点，1 表示返回 83 个人脸关键点
        map.put("return_attributes", "gender,age,smiling,headpose,facequality,blur,eyestatus,emotion,ethnicity,beauty,mouthstatus,eyegaze,skinstatus"); // 是否检测并返回根据人脸特征判断出的年龄、性别、情绪等属性
        map.put("image_base64", imgBase64);

        DataResp dataResp = new DataResp();

        String respString = "";
        try {
            byte[] respByte = post(FACE_API_DETECT, map, null);

            respString = new String(respByte);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!StringUtils.isEmpty(respString)) {
            System.out.println("脸部识别响应：" + respString);
            JSONObject json = JSON.parseObject(respString);
            // 被检测出的人脸数组
            JSONArray faces = json.getJSONArray("faces");
            if (faces.size() > 0) {
                // 默认取识别出的第一张人脸
                JSONObject face = (JSONObject) faces.get(0);

                System.out.println(face.toString());
                // 获取 facequality 字段，用于判断图片质量是否可以用于后续的人脸对比
                JSONObject fq = face.getJSONObject("attributes").getJSONObject("facequality");

                //-- 打印测试下嘴巴状态
                JSONObject mouthStatus = face.getJSONObject("attributes").getJSONObject("mouthstatus");
                System.out.println("嘴巴状态：" + mouthStatus.toString());

                // 测试下眼睛状态
                JSONObject eyeStatus = face.getJSONObject("attributes").getJSONObject("eyestatus");
                System.out.println("眼睛状态：" + eyeStatus);
                //--

                if (validateFaceQuality(fq)) {
                    dataResp.setCode(DataResp.Code.SUCCESS);
                    dataResp.setMessage("录入成功");
                    // 返回识别的脸部 json 数据，用于后续操作
                    dataResp.setData(face);
                } else {
                    dataResp.setCode(DataResp.Code.ERROR);
                    dataResp.setMessage("请端正姿势");
                    System.out.println("请端正姿势");
                }

            } else {
                dataResp.setCode(DataResp.Code.ERROR);
                dataResp.setMessage("识别不到人脸");
                System.out.println("识别不到人脸");
            }
        }

        return dataResp;
    }

    /**
     * 人脸对比
     * @return
     */
    public static DataResp faceCompare(String imgBase64No1, String imgBase64No2) {

        HashMap<String, String> map = new HashMap<>();
        map.put("api_key", API_KEY);
        map.put("api_secret", API_SECRET);
        map.put("image_base64_1", imgBase64No1); // 用于对比的第一张 base64 编码图片
        map.put("image_base64_2", imgBase64No2); // 用于对比的第二张 base64 编码图片
        DataResp dataResp = new DataResp();

        String respString = "";
        try {
            byte[] respByte = post(FACE_API_COMPARE, map, null);

            respString = new String(respByte);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!StringUtils.isEmpty(respString)) {
            System.out.println("脸部对比响应：" + respString);

            JSONObject json = JSON.parseObject(respString);
            if (validateFaceConfidence(json)) {
                dataResp.setCode(DataResp.Code.SUCCESS);
                dataResp.setMessage("刷脸对比成功");
                dataResp.setData(json);
            } else {
                dataResp.setCode(DataResp.Code.ERROR);
                dataResp.setMessage("刷脸失败，不是同一个人");
                dataResp.setData(json);
            }
        }

        return dataResp;
    }

    /**
     * 校验人脸质量
     * @return
     */
    public static boolean validateFaceQuality(JSONObject fq) {
        if (fq != null) {
            // value 人脸的质量判断的分数，是一个浮点数
            double value = fq.getDouble("value");
            // threshold 表示人脸质量基本合格的一个阈值，超过该阈值的人脸适合用于人脸比对
            double threshold = fq.getDouble("threshold");

            return value > threshold;
        }

        return false;
    }

    /**
     * 校验置信度，也就是判断是不是同一个人
     * @return
     */
    public static boolean validateFaceConfidence(JSONObject json) {
        if (json != null) {
            // 获取比对结果置信值
            double confidence = json.getDouble("confidence");
            // 获取误识率为十万分之一的置信度阈值
            double threshold1E5 = json.getJSONObject("thresholds").getDouble("1e-5");

            // 如果置信值超过“十万分之一”阈值，则是同一个人的几率非常高
            return confidence > threshold1E5;
        }
        return false;
    }

    /**
     * 张张嘴或眨眨眼检测
     * @param imgBase64
     * @param checkType
     * @param userId
     * @return // 返回 0/1/-1，1 代表成功；0 代表继续检测；-1 代表检测失败，认为不是活体
     */
    public static synchronized DataResp aliveCheck(String imgBase64, String checkType, String userId) {

        System.out.println("正在检测====>>>>>>>>>" + (checkType.equals(CHECK_TYPE_MOUTH) ? "张张嘴" : "眨眨眼"));

        DataResp dataResp = faceDetect(imgBase64);

        // 当前识别到的脸，是一个 JSONObject
        JSONObject currentFace = (JSONObject) dataResp.getData();

        if (dataResp.getCode() == DataResp.Code.SUCCESS) {

            Map<String, Object> tmpMap = null;

            // 根据检测类型，引用对应的 map
            if (checkType.equals(CHECK_TYPE_MOUTH)) {
                tmpMap = mouthCheckMap;
            } else {
                tmpMap = eyeCheckMap;
            }

            JSONObject sourceFace = (JSONObject) tmpMap.get(userId);
            if (sourceFace == null) {
                // 如果是第一次请求，就把第一次的脸部特征当作后续比较的参考对象
                tmpMap.put(userId, currentFace);
                // 并初始化检测失败次数为 0
                tmpMap.put(userId + KEY_FAILED_COUNT, 0);
                dataResp.setData(0);
                dataResp.setMessage("需继续检测");
                dataResp.setCode(DataResp.Code.SUCCESS);
            } else {
                // 否则，就把当前识别的脸和第一次的脸做比较
                // 把当前的 face 的 mouth 特征和第一次的 face 的 mouth 特征取出，并进行比较
                String currentFaceStatus = getStatus(currentFace, checkType);
                String sourceFaceStatus = getStatus(sourceFace, checkType);
                // 判断两次的状态是否一致
                if (!currentFaceStatus.equals(sourceFaceStatus)) {
                    // 如果不一致，则证明摄像头前的人是活动着的，检测通过
                    dataResp.setData(1);
                    dataResp.setCode(DataResp.Code.SUCCESS);
                    dataResp.setMessage("检测通过");
                    // 检测通过需要把该用户对用的 map 里的值清掉，否则会影响下次的检测
                    clearMapKey(tmpMap, userId);
                } else {
                    // 否则，继续检测，记录失败次数，超过一定失败次数则检测不通过，则认为摄像头前的人是不动的
                    int failedCount = (Integer) tmpMap.get(userId + KEY_FAILED_COUNT);
                    System.out.println("检测失败次数："+failedCount);
                    if (failedCount > CHECK_FAILED_THRESHOLD) {
                        dataResp.setData(-1);
                        dataResp.setCode(DataResp.Code.ERROR);
                        dataResp.setMessage("检测失败，检测对象没有按提示活动");
                        // 检测失败了，也要清掉 map 对应的数据
                        clearMapKey(tmpMap, userId);
                    } else {
                        failedCount++;
                        tmpMap.put(userId + KEY_FAILED_COUNT, failedCount);
                        dataResp.setData(0);
                        dataResp.setCode(DataResp.Code.SUCCESS);
                        dataResp.setMessage("需继续检测");
                    }
                }
            }
        }

        return dataResp;
    }

    /**
     * 根据分数判断是张开还是闭合
     * @param value
     */
    public static String validateStatus(double open, double close) {
        // 如果 open 的分值比 close 的分值大，则认为是打开的，否则相反
        return open > close ? STATUS_OPEN : STATUS_CLOSE;
    }

    /**
     * 清除 map 中的值
     */
    private static void clearMapKey(Map<String, Object> map, String key) {
        map.remove(key);
        map.remove(key + KEY_FAILED_COUNT);
    }

    /**
     * 获取嘴巴或眼睛张合状态
     * @param face
     * @param checkType
     * @return
     */
    private static String getStatus(JSONObject face, String checkType) {
        String status = "";
        if (checkType.equals(CHECK_TYPE_MOUTH)) {
            // mouthstatus 字段记录了嘴巴的状态
            JSONObject mouthStatus = face.getJSONObject("attributes").getJSONObject("mouthstatus");
            // 获取 mouthstatus 字段的子字段 open 和 close，这两个是浮点数的分值，并确定状态
            status = validateStatus(mouthStatus.getDouble("open"), mouthStatus.getDouble("close"));
        } else {
            // eyestatus 字段记录眼睛状态数据，他的子字段 left_eye_status 和 right_eye_status 又分别记录了左右眼的状态
            JSONObject eyeStatus = face.getJSONObject("attributes").getJSONObject("eyestatus");
            // 分别获取左右眼的状态
            JSONObject leftEyeStatus = eyeStatus.getJSONObject("left_eye_status");
            JSONObject rightEyeStatus = eyeStatus.getJSONObject("right_eye_status");

            System.out.println("leftEyeStatus:"+leftEyeStatus);

            // 左右眼状态中的子字段 no_glass_eye_open 和 no_glass_eye_close 分别记录了不戴眼镜睁开眼的置信度和不戴眼镜闭眼的置信度，都是浮点数来的（这里只考虑不戴眼镜的😄）
            String ls = validateStatus(leftEyeStatus.getDouble("no_glass_eye_open"), leftEyeStatus.getDouble("no_glass_eye_close"));
            String rs = validateStatus(rightEyeStatus.getDouble("no_glass_eye_open"), rightEyeStatus.getDouble("no_glass_eye_close"));

            // 这里如果左右眼的状态一致的话，返回其中一个就行了
            if (ls.equals(rs)) {
                status = ls;
            } else {
                // 如果左右眼不一样，那应该是在放电了 😂
                // 不过放在本例也算合理，也算眨了眼睛了，也取其中一个吧
                System.out.println("请不要对我放电~🙈");
                status = ls;
            }
        }
        return status;
    }
}
