package com.oneplus.localmanifest;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class MainActivity extends Activity {
    
    private TextView statusText;
    private Button generateRoomserviceButton;
    private Button generateLocalManifestButton;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        statusText = findViewById(R.id.statusText);
        generateRoomserviceButton = findViewById(R.id.generateRoomserviceButton);
        generateLocalManifestButton = findViewById(R.id.generateLocalManifestButton);
        
        generateRoomserviceButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                generateRoomserviceXml();
            }
        });
        
        generateLocalManifestButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                generateLocalManifestsXml();
            }
        });
    }
    
    private void generateRoomserviceXml() {
        String xmlContent = getRoomserviceXmlContent();
        boolean success = writeXmlFile("roomservice.xml", xmlContent);
        
        if (success) {
            statusText.setText("Generated roomservice.xml successfully!");
            Toast.makeText(this, "Created: local_manifests/roomservice.xml", Toast.LENGTH_LONG).show();
        } else {
            statusText.setText("Failed to generate roomservice.xml");
            Toast.makeText(this, "Failed to create file", Toast.LENGTH_SHORT).show();
        }
    }
    
    private void generateLocalManifestsXml() {
        String xmlContent = getRoomserviceXmlContent();
        boolean success = writeXmlFile("local_manifests.xml", xmlContent);
        
        if (success) {
            statusText.setText("Generated local_manifests.xml successfully!");
            Toast.makeText(this, "Created: local_manifests/local_manifests.xml", Toast.LENGTH_LONG).show();
        } else {
            statusText.setText("Failed to generate local_manifests.xml");
            Toast.makeText(this, "Failed to create file", Toast.LENGTH_SHORT).show();
        }
    }
    
    private String getRoomserviceXmlContent() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
               "<!--\n" +
               "Copyright (C) 2024 The Android Open Source Project\n" +
               "SPDX-License-Identifier: Apache-2.0\n" +
               "-->\n" +
               "<manifest>\n" +
               "  <!-- OnePlus Larry (CPH2515) Device Tree -->\n" +
               "  <project name=\"kay6888/twrp_device_oneplus_larry\" path=\"device/oneplus/larry\" remote=\"github\" revision=\"main\" />\n" +
               "  \n" +
               "  <!-- Kernel -->\n" +
               "  <project name=\"oneplus/kernel_oneplus_sm6375\" path=\"kernel/oneplus/sm6375\" remote=\"github\" revision=\"main\" />\n" +
               "  \n" +
               "  <!-- Vendor -->\n" +
               "  <project name=\"oneplus/vendor_oneplus_larry\" path=\"vendor/oneplus/larry\" remote=\"github\" revision=\"main\" />\n" +
               "</manifest>\n";
    }
    
    private boolean writeXmlFile(String filename, String content) {
        try {
            File externalDir = Environment.getExternalStorageDirectory();
            File localManifestsDir = new File(externalDir, "local_manifests");
            
            if (!localManifestsDir.exists()) {
                localManifestsDir.mkdirs();
            }
            
            File xmlFile = new File(localManifestsDir, filename);
            FileOutputStream fos = new FileOutputStream(xmlFile);
            fos.write(content.getBytes());
            fos.close();
            
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
